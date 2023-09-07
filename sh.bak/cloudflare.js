const Authorization = "Bearer " + process.env.CLOUDFLARE_token,
	URL =
		"https://api.cloudflare.com/client/v4/zones/" +
		process.env.CLOUDFLARE_zone +
		"/";

export default async (url, data) => {
	const r = await (
		await fetch(URL + url, {
			method: "POST",
			headers: {
				Authorization,
				"Content-Type": "application/json",
			},
			body: JSON.stringify(data),
		})
	).json();
	if (r.success) {
		return r.result;
	} else {
		throw new Error(JSON.stringify(r.errors));
	}
};
