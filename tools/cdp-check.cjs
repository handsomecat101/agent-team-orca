// Mẫu kiểm giao diện app THẬT qua Chrome DevTools Protocol (WebView2 / Chrome / Edge / Electron).
// Node >= 22 (có sẵn fetch + WebSocket, không cần cài gói).
// Mở app với cổng CDP: WebView2 -> biến môi trường WEBVIEW2_ADDITIONAL_BROWSER_ARGUMENTS=--remote-debugging-port=9226
//                      Chrome/Edge -> --remote-debugging-port=9226
// Dùng: node tools/cdp-check.cjs <port> <urlChứa> <ảnh_ra.png>
// Sửa phần KỊCH BẢN cho dự án của bạn. Leader xem ảnh + số đo + lỗi console rồi mới kết luận.
const [PORT = "9226", URL_PART = "localhost", OUT = "cdp-check.png"] = process.argv.slice(2);
const fs = require("fs");
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
let seq = 1;

async function connect() {
  for (let i = 0; i < 40; i++) {
    try {
      const list = await (await fetch(`http://127.0.0.1:${PORT}/json/list`)).json();
      const page = list.find((t) => t.type === "page" && t.url.includes(URL_PART));
      if (page) {
        const ws = new WebSocket(page.webSocketDebuggerUrl);
        await new Promise((r, j) => { ws.onopen = r; ws.onerror = j; });
        return ws;
      }
    } catch {}
    await sleep(1500);
  }
  throw new Error("không thấy trang chứa " + URL_PART);
}
const call = (ws, method, params = {}) => new Promise((resolve, reject) => {
  const id = seq++;
  ws.addEventListener("message", function h(ev) {
    const m = JSON.parse(ev.data);
    if (m.id === id) { ws.removeEventListener("message", h); m.error ? reject(new Error(JSON.stringify(m.error))) : resolve(m.result); }
  });
  ws.send(JSON.stringify({ id, method, params }));
});
const js = async (ws, expr) => (await call(ws, "Runtime.evaluate", { expression: expr, returnByValue: true, awaitPromise: true }))?.result?.value;
const clickText = (text) => `(() => { const el = [...document.querySelectorAll('button, a, [role=tab]')].find(e => (e.innerText||'').trim().startsWith(${JSON.stringify(text)}) && e.offsetParent); if (!el) return 'KHONG THAY: ${text}'; el.click(); return 'ok'; })()`;

(async () => {
  const ws = await connect();
  const errors = [];
  ws.addEventListener("message", (ev) => {
    const m = JSON.parse(ev.data);
    if (m.method === "Runtime.exceptionThrown") errors.push("EXC " + (m.params.exceptionDetails.exception?.description || m.params.exceptionDetails.text).slice(0, 300));
    if (m.method === "Runtime.consoleAPICalled" && m.params.type === "error") errors.push("ERR " + m.params.args.map((a) => a.value ?? a.description ?? "").join(" ").slice(0, 300));
  });
  await call(ws, "Runtime.enable");
  await call(ws, "Page.enable");
  await call(ws, "Page.reload", { ignoreCache: true });
  await sleep(8000);

  // ===== KỊCH BẢN (sửa cho dự án) =====
  console.log("kích thước trang:", await js(ws, `JSON.stringify({ w: document.documentElement.scrollWidth, h: document.documentElement.scrollHeight, vw: innerWidth })`));
  // console.log(await js(ws, clickText("Cài đặt"))); await sleep(2000);
  // ====================================

  const shot = await call(ws, "Page.captureScreenshot", { format: "png" });
  fs.writeFileSync(OUT, Buffer.from(shot.data, "base64"));
  console.log("ảnh:", OUT);
  console.log("lỗi console (" + errors.length + "):\n" + [...new Set(errors)].slice(0, 25).join("\n"));
  ws.close();
  process.exit(0);
})().catch((e) => { console.error("FAIL:", e.message); process.exit(1); });
