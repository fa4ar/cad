// Simple radio toggle handler
window.addEventListener('message', function(event) {
    if (event.data && event.data.type === "radioToggle") {
        var radio = document.getElementById('radio');
        if (radio) {
            radio.style.display = event.data.state ? "block" : "none";
        }
    }
});

// Ensure payloads include channel/zone in line1/line2 when sending JSON
;(function() {
  try {
    var _origFetch = window.fetch.bind(window);
    window.fetch = async function(input, init) {
      try {
        // Only attempt JSON POST/PUT with a body
        var isJsonRequest = false;
        var bodyText = null;
        var headers = {};
        if (init) {
          if (init.headers) {
            if (typeof init.headers === 'string') {
              // headers as string not easily parsed; skip
            } else {
              headers = init.headers;
            }
          }
          if (init.body && typeof init.body === 'string') {
            bodyText = init.body;
            // Heuristic: if Content-Type header indicates json, treat as JSON
            var ct = (headers['Content-Type'] || headers['content-type'] || '');
            isJsonRequest = ct.indexOf('application/json') !== -1;
          }
        }
        // If input is a URL string and there is a body with JSON
        if (isJsonRequest && bodyText) {
          var payload;
          try { payload = JSON.parse(bodyText); } catch (e) { payload = null; }
          if (payload && (typeof payload.line1 === 'undefined' || typeof payload.line2 === 'undefined')) {
            // Try to derive channel/zone from payload or global state
            var channel = payload.channel || (window && window.channel);
            var zone = payload.zone || (window && window.zone);
            // If not found, fall back to known globals or defaults
            if (typeof channel === 'undefined' || channel === null) channel = (window && window.CURRENT_CHANNEL) || 'unknown';
            if (typeof zone === 'undefined' || zone === null) zone = (window && window.CURRENT_ZONE) || 'unknown';
            var text1 = payload.text1 || '';
            var text2 = payload.text2 || '';
            payload.line1 = 'Channel=' + String(channel) + ' | Zone=' + String(zone) + ' | ' + String(text1);
            payload.line2 = 'Channel=' + String(channel) + ' | Zone=' + String(zone) + ' | ' + String(text2);
            init = Object.assign({}, init, { body: JSON.stringify(payload) });
          }
        }
      } catch (e) {
        // guard: do not block original request on any error in the patch logic
      }
      return _origFetch(input, init);
    };
  } catch (e) {
    // ignore patch errors
  }
})();
