var l,u,w,f,m,d,p,g;f=console;u=location.host;({protocol:p,host:u}=location);g=e=>new Promise(r=>setTimeout(r,e));d=()=>parseInt(new Date/1e3);w=async e=>{var r,a,o,n,c,t,i,s;if(s=new URL(e.url),s.host!==u){a={credentials:"omit",mode:"cors"};try{t=await fetch(e,a)}catch(h){o=h,delete a.mode,t=await fetch(e,a)}}else t=await fetch(e);return t&&(n=[200,301,304].includes(t.status),n&&(t.ok=n,r=t.headers.get("cache-control")||"",r!=="no-cache"&&(i=/max-age=(\d+)/.exec(r),i&&(i=+i[1],i>0&&(c=new Response(t.clone().body,t),c.headers.set("@",(d()+i).toString(36)),caches.open(2).then(h=>h.put(e,c))))))),t};m=async e=>{var r,a;for(a=0;;)try{return await w(e)}catch(o){if(r=o,a++>9)throw r;f.error(a,e,r)}};l={install:e=>{e.waitUntil(skipWaiting())},activate:e=>{e.waitUntil(clients.claim())},fetch:e=>{var r,a,o,n,c;n=e.request,{url:c,method:a}=n,c.startsWith("http")&&(["GET","OPTIONS"].indexOf(a)<0||n.headers.get("accept").includes("stream")||({host:r}=c=new URL(c),{pathname:o}=c,r===u&&!o.includes(".")&&(n=new Request("/",{method:a})),e.respondWith(caches.match(n).then(async t=>{var i,s;if(t&&parseInt(t.headers.get("@"),36)>d())return t;try{s=await m(n)}catch(h){if(i=h,t)return f.error(i),t;throw i}return t&&t.ok&&!s.ok?t:s}))))}};(()=>{var e,r;for(e in l)r=l[e],addEventListener(e,r)})()
