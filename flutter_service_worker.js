'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "0a4fb26f5f4efc1b8821daf81be22c1e",
"assets/assets/fonts/RobotoMono/RobotoMono-Bold.ttf": "e72fdf1cca2cebcbe91325bbe9f9e5da",
"assets/assets/fonts/RobotoMono/RobotoMono-BoldItalic.ttf": "9f19015ac5913e03cdd542eb73d17d12",
"assets/assets/fonts/RobotoMono/RobotoMono-ExtraLight.ttf": "9bab8fe7af63fb4a1d536f0690799953",
"assets/assets/fonts/RobotoMono/RobotoMono-ExtraLightItalic.ttf": "2186a1bc18fe3a5b9d35b1f0a9661f97",
"assets/assets/fonts/RobotoMono/RobotoMono-Italic.ttf": "4e76966e85cfc4edb3db058576edcb1b",
"assets/assets/fonts/RobotoMono/RobotoMono-Light.ttf": "fa8ab495d494eccb28f4431f054ddbd4",
"assets/assets/fonts/RobotoMono/RobotoMono-LightItalic.ttf": "060d28a8c0576728842455c0a92641e0",
"assets/assets/fonts/RobotoMono/RobotoMono-Medium.ttf": "8ad82b1dc550319993a7d6c932b2656d",
"assets/assets/fonts/RobotoMono/RobotoMono-MediumItalic.ttf": "50fcbc561a338706746be330f2b7ef99",
"assets/assets/fonts/RobotoMono/RobotoMono-Regular.ttf": "e5ca8c0ac474df46fe45840707a0c483",
"assets/assets/fonts/RobotoMono/RobotoMono-SemiBold.ttf": "2a12618b6d46fd798157e4b9d29cdf06",
"assets/assets/fonts/RobotoMono/RobotoMono-SemiBoldItalic.ttf": "e0781b003f2cd1145518cc5f5f8d134c",
"assets/assets/fonts/RobotoMono/RobotoMono-Thin.ttf": "7cb58857d294ac1e09b72ea9403c690a",
"assets/assets/fonts/RobotoMono/RobotoMono-ThinItalic.ttf": "95e08d0c587d02c33914026841dd5e89",
"assets/FontManifest.json": "6970f4e567c7f7ced573945e0bb7b237",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "2f0d763b46c380037826bd4f48362a9a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "0f02bb5bc53bb19d203d1e90a19b892c",
"/": "0f02bb5bc53bb19d203d1e90a19b892c",
"main.dart.js": "a78bfb2cfba775ca7177aa4a95df254c",
"manifest.json": "a1eae8482c7985d7fe52d24148d59129",
"version.json": "215c76fbd9287b60f4ce0656329550a8"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
