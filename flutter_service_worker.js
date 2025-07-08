'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "e9c1dc39b139977df6ad1d196be75ef2",
".git/config": "5387c986d74531b9533efe26a8ac4a4e",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "fd1cadba677c06a762b35aa4e2a13fe5",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "bcb72a42e488b20a7ed384d867040a0a",
".git/logs/refs/heads/gh-pages": "e689d05c9491ba386feb9926279656ec",
".git/logs/refs/remotes/origin/gh-pages": "643d1452bfd42e50bd5c569295ec98f4",
".git/objects/1a/b3a651c6f33d945f0876715fc4fceaa62063cc": "3ecdd8f5c69a7f31c7973c737df84cc1",
".git/objects/1a/d7683b343914430a62157ebf451b9b2aa95cac": "94fdc36a022769ae6a8c6c98e87b3452",
".git/objects/22/00b8d5dbd9c89e6f061e74290d2a0751934691": "c826cc0ec03427c3a60a3c22c17146db",
".git/objects/2a/7cc77391409cf46a995b387ab2d6c5e597b1b1": "51ac40dcddd7a3b694ce734f67f2c9cf",
".git/objects/2d/a0ef85e04298d6348a3afffa1be2287099918e": "63da40e4dc0585c58db9583cb6b6cde6",
".git/objects/36/73071b47d110d51d6c31180c3226ad36f15448": "985c8b0a788e840d412df87971661759",
".git/objects/3b/8b977dddd225dccd9f78d57359dd1b74f9fcca": "8973064e258d8b1fa60d5ab98d793d1f",
".git/objects/3c/5eba0518934c751995703c98a69e38cf4f7342": "e8e4511190c48d45a709dc0075fdb6b6",
".git/objects/3f/183e16cefd78ccb6268a358b1103c9c931a559": "5ad3992ba75453aed8b107892e492d25",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/4b/abc034e64b5dbb0f4a25c587020ad0a4037b54": "c6f2405a338f14ba885c73783798da69",
".git/objects/4c/51fb2d35630595c50f37c2bf5e1ceaf14c1a1e": "a20985c22880b353a0e347c2c6382997",
".git/objects/53/18a6956a86af56edbf5d2c8fdd654bcc943e88": "a686c83ba0910f09872b90fd86a98a8f",
".git/objects/53/3d2508cc1abb665366c7c8368963561d8c24e0": "4592c949830452e9c2bb87f305940304",
".git/objects/55/20ba58cf6a9cca6bf90a3a997dc36babbacaf8": "61899f2433bf3a85c277e8c84d8c7cea",
".git/objects/55/8fc5995b171a3d398743a4e41d0907941aa057": "9be86b2a0cfaaccfd439936971b348cd",
".git/objects/5b/1f060c48d1009cffce3861a6b1d414b6568eab": "c513b5927f033dc737062dd019fff580",
".git/objects/69/55e7cfc50084d6f9cada6fc9dfa44e977fd173": "978b32c1a71953902dbefb62dec9f946",
".git/objects/69/9c77fca1ffe7e5516326af077d9d9fe4794140": "9cce7ea8f77c71228fb82b0d46209340",
".git/objects/6b/31444231a63ef878230f21d2bdb6e0ba6d43a4": "74f0e347d2ee1a1b50a9c455121f0dd0",
".git/objects/70/a234a3df0f8c93b4c4742536b997bf04980585": "d95736cd43d2676a49e58b0ee61c1fb9",
".git/objects/73/c63bcf89a317ff882ba74ecb132b01c374a66f": "6ae390f0843274091d1e2838d9399c51",
".git/objects/7c/91c0bce0a5c3fb12399606c6f59cdaa976c9b6": "d1a56e6670e192cbf0349b59aaf9e971",
".git/objects/82/6b578fa531139befbb58048d00b41362fa3e75": "733a4a2b0b3975cf06b98e73dec570cc",
".git/objects/88/c9e4cbb6b7eaa5cf8bed6818a60dced8211302": "76dcfd9362a2034cfdd165ad8faabba4",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8d/41d16201131d3b28b8fefaddda3c8766b83d41": "5a762177f191ff92c098da3365d96c8a",
".git/objects/8e/3c7d6bbbef6e7cefcdd4df877e7ed0ee4af46e": "025a3d8b84f839de674cd3567fdb7b1b",
".git/objects/8f/8c2a58a526e5b980eba9afeea6e8343aafab7b": "5b71603e1c0cc8db432488a2fd8cbe19",
".git/objects/91/f6de8bb8cc4027bd4b3c5e8a96dd5218bacc48": "ae2ffcb44a4f50a7a7f676d8cb31e82f",
".git/objects/94/014c0e9aa0ef83810a6783f4f6d7d4b9b132fb": "5a3ddc8318266f20c157bc9e048c4fa4",
".git/objects/9b/d3accc7e6a1485f4b1ddfbeeaae04e67e121d8": "784f8e1966649133f308f05f2d98214f",
".git/objects/af/ffdf91fd9a701e5a3ed86329d9b3c6a6dae961": "1e6f580d7cfa194c0e1e070f4a0a1673",
".git/objects/b6/bc4b2519b7088e04e9a18825217a2c91ad5db1": "4caebbb8711d20968e440d264d7a47e5",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/6a5236065a6c0fb7193cb2bb2f538b2d7b4788": "4227e5e94459652d40710ef438055fe5",
".git/objects/bd/f739097fa3c7c697f6f42e04cbb70ba7b39dd5": "333da4119adb58b9d101f9ad934aca39",
".git/objects/c3/58f8ca3a489c6a02f79db2d277d46963a74b9b": "68d0fb0e6afd1e9aa3afee2e623bf610",
".git/objects/c8/08fb85f7e1f0bf2055866aed144791a1409207": "92cdd8b3553e66b1f3185e40eb77684e",
".git/objects/d3/a9be635b5ca8c242992fa3148416192caeeb94": "9a6d1510f7f1b93ae202ea5b72d9f1cf",
".git/objects/d4/228c06b45b267574313fd7a241fa03ff04ed1e": "ed206d47fd420a5462a4b1e383d1d50f",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/dc/11fdb45a686de35a7f8c24f3ac5f134761b8a9": "761c08dfe3c67fe7f31a98f6e2be3c9c",
".git/objects/de/787b7fc2cd1ba25533c81f9aa32fa6d95c90b0": "f18e15d6f8a6e50419f17302f37bf4ba",
".git/objects/e0/7ac7b837115a3d31ed52874a73bd277791e6bf": "74ebcb23eb10724ed101c9ff99cfa39f",
".git/objects/e9/ff3fdf3b475148ac82404690dd41d9e9bfc166": "2706166b6c3b3cc30229185eea3dd4fc",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ef/42df16b052f3ca5f4cb5d7378bf8e9ba994018": "68a8ba75a63b2af9983404fef50e37f1",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f3/59748e54e345488b07bf0b772ef180eb3705c1": "5c2d53d204742a33b1e1dd8e0e22efa3",
".git/objects/f4/93092ab93c54b917c530875633f132ef083600": "c7dd0366753a63501b35a44b4ab45c64",
".git/objects/fd/567c1a34f89d1a2591e577bfe2323c28e37416": "270deefa1c9b7dd170f97f1a3a534ce9",
".git/refs/heads/gh-pages": "bd050f11ed7cc50fa0d7b970b29811b2",
".git/refs/remotes/origin/gh-pages": "bd050f11ed7cc50fa0d7b970b29811b2",
"assets/AssetManifest.bin": "8c83751eeff2b227f798857d0ebbda8b",
"assets/AssetManifest.bin.json": "907364356b59c77729dd0ff55d095e96",
"assets/AssetManifest.json": "11eb26bfe1ff831afa2b1c3264fed3cc",
"assets/assets/images/trash.png": "0fa6795a128dd1399204bb42ce45da31",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "d687265b4f38c7f0d3742ad36de4610f",
"assets/NOTICES": "225f51a54467104474bc11f12f62f41a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "84652f57c95aab33baa1f4bb5e9de862",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "aca6a35422e01376a9490d977805b1a4",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f69942c6c2af0ec1a799e82f611a41eb",
"/": "f69942c6c2af0ec1a799e82f611a41eb",
"main.dart.js": "6521a70217fbcc50236259a88352f010",
"manifest.json": "76edceb2400931d9f6483b1f156b5a53",
"version.json": "6bb9b686201316c3423b85103a251bbb"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
