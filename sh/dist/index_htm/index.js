await (async () => {
	var activated = "activated",
		statechange = "statechange",
		reg = await navigator.serviceWorker.register(`/s.js`),
		sw = reg.active || reg.installing;

	await new Promise((resolve) => {
		if (sw.state === activated) {
			return resolve();
		} else {
			var _state = function (e) {
				if (this.state === activated) {
					resolve();
					return sw.removeEventListener(statechange, _state);
				}
			};
			return sw.addEventListener(statechange, _state);
		}
	});
	var url = "//usr.tax/",
		add = (tag, attr) => {
			var d = document,
				s = d.createElement(tag);
			Object.assign(s, attr);
			d.head.appendChild(s);
		},
		[c, j] = (await (await fetch(url + "v")).text()).split(" ");
	add("script", {
		type: "module",
		src: url + j,
	});
	add("link", {
		rel: "stylesheet",
		href: url + c,
	});
})();
