var f,s,k,w,d,m,p,v;d=console;s=location.host;({protocol:p,host:s}=location);k=p+`//${s}/`;v=e=>new Promise(t=>setTimeout(t,e));w=async e=>{var t,i,c,n,r,a;if(a=new URL(e.url),a.host!==s){t={credentials:"omit",mode:"cors"};try{r=await fetch(e,t)}catch(o){i=o,delete t.mode,r=await fetch(e,t)}}else r=await fetch(e);return r&&(c=[200,301,304].includes(r.status),c&&(r.ok=c,n=new Response(r.clone().body,r),n.headers.set("_",parseInt(new Date/1e3).toString(16)),caches.open(1).then(o=>o.put(e,n)))),r};m=async e=>{var t,i;for(i=0;;)try{return await w(e)}catch(c){if(t=c,i++>9)throw t;d.error(i,e,t)}};f={install:e=>{e.waitUntil(skipWaiting())},activate:e=>{e.waitUntil(clients.claim())},fetch:e=>{var t,i,c,n,r;n=e.request,{url:r,method:i}=n,r.startsWith("http")&&(["GET","OPTIONS"].indexOf(i)<0||n.headers.get("accept").includes("stream")||({host:t}=r=new URL(r),{pathname:c}=r,t===s&&!c.includes(".")&&(n=new Request("/",{method:i})),e.respondWith(caches.match(n).then(async a=>{var o,h,u,l;if(a)for(o=a.headers.get("cache-control")||"";!(o&&(o==="no-cache"||(l=/max-age=(\d+)/.exec(o),l&&new Date/1e3-parseInt(a.headers.get("_"),16)-l[1]>0)));)return a;try{u=await m(n)}catch(g){if(h=g,a)return d.error(h),a;throw h}return a&&a.ok&&!u.ok?a:u}))))}};(()=>{var e,t;for(e in f)t=f[e],addEventListener(e,t)})()
