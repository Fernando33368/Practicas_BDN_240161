import fs from 'node:fs';

const root = new URL('../docs/', import.meta.url);
const source = new URL('./source/', import.meta.url);
const dictionary = fs.readFileSync(new URL('diccionario-datos.html', source));
const erd = fs.readFileSync(new URL('diagrama-erd.html', source));
const b64 = (buffer) => buffer.toString('base64');
const page = `<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="Diccionario de datos y diagrama entidad-relación de db_test_240161.">
  <title>Diccionario y diagrama ER · db_test_240161</title>
  <style>
    :root{color-scheme:dark;--bg:#080d18;--panel:#111a2a;--line:#26364c;--ink:#eaf1fc;--muted:#9baec7;--accent:#6ce5dc}
    *{box-sizing:border-box}html,body{margin:0;width:100%;height:100%;background:var(--bg);color:var(--ink);font:15px/1.45 system-ui,Segoe UI,sans-serif}
    .shell{height:100%;display:grid;grid-template-rows:auto 1fr}.top{position:relative;z-index:2;background:var(--panel);border-bottom:1px solid var(--line);padding:10px clamp(12px,3vw,30px);display:flex;align-items:center;justify-content:space-between;gap:14px;flex-wrap:wrap}
    .brand{font-weight:700;letter-spacing:.01em}.brand small{display:block;font-weight:400;color:var(--muted);font-size:.78rem}.tabs{display:flex;gap:8px}.tab{border:1px solid #3c536c;border-radius:9px;background:#0a1220;color:var(--ink);padding:9px 14px;font:inherit;cursor:pointer}.tab[aria-selected="true"]{background:#123640;border-color:var(--accent);color:var(--accent)}
    .views{min-height:0;position:relative}.view{position:absolute;inset:0;width:100%;height:100%;border:0;background:#fff;display:none}.view.active{display:block}
    @media(max-width:600px){.top{align-items:flex-start}.tabs{width:100%}.tab{flex:1}}
  </style>
</head>
<body><div class="shell">
  <header class="top"><div class="brand">db_test_240161<small>Diccionario de datos y diagrama entidad-relación</small></div>
    <nav class="tabs" role="tablist" aria-label="Secciones del documento">
      <button class="tab" id="tab-dictionary" role="tab" aria-selected="true" aria-controls="view-dictionary">Diccionario de datos</button>
      <button class="tab" id="tab-erd" role="tab" aria-selected="false" aria-controls="view-erd">Diagrama ER</button>
    </nav>
  </header>
  <main class="views">
    <iframe class="view active" id="view-dictionary" title="Diccionario de datos" sandbox="allow-scripts allow-same-origin allow-downloads"></iframe>
    <iframe class="view" id="view-erd" title="Diagrama entidad-relación" sandbox="allow-scripts allow-same-origin allow-downloads"></iframe>
  </main>
</div>
<script>
const embedded={dictionary:"${b64(dictionary)}",erd:"${b64(erd)}"};
function loadFrame(id,payload){const bytes=Uint8Array.from(atob(payload),c=>c.charCodeAt(0));document.getElementById(id).srcdoc=new TextDecoder().decode(bytes)}
loadFrame('view-dictionary',embedded.dictionary);loadFrame('view-erd',embedded.erd);
const tabs=[...document.querySelectorAll('[role=tab]')],views=[...document.querySelectorAll('.view')];
function select(i){tabs.forEach((t,n)=>t.setAttribute('aria-selected',String(i===n)));views.forEach((v,n)=>v.classList.toggle('active',i===n));tabs[i].focus()}
tabs.forEach((t,i)=>{t.addEventListener('click',()=>select(i));t.addEventListener('keydown',e=>{if(e.key==='ArrowRight'||e.key==='ArrowLeft'){e.preventDefault();select((i+(e.key==='ArrowRight'?1:tabs.length-1))%tabs.length)}})});
</script></body></html>`;
fs.writeFileSync(new URL('index.html', root), page, 'utf8');
console.log(`Página única generada (${Buffer.byteLength(page)} bytes).`);
