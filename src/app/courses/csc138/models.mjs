export function xargs({input,n=2,replace='',noEmpty=false,mode='reference',command='echo',fixed=[]}){
 if(typeof input!=='string'||input.length>2000||!Number.isInteger(n)||n<1||n>20||fixed.length>12)throw Error('Use up to 2000 input characters, 1–20 items per batch and 12 fixed arguments.');
 const lines=input.split(/\r?\n/),read=[];for(const line of lines){if(mode==='source'&&!line.trim())break;read.push(line);}
 const raw=read.join(' ').trim().split(/\s+/).filter(Boolean);if(raw.length>200)throw Error('Limit the input to 200 tokens.');
 const tokens=raw.map(t=>mode==='source'?t.replace(/;&|><*?$()/g,''):t.replace(/[;&|><*?$()]/g,''));
 const prefix=[command,...fixed],commands=[];
 if(replace&&(mode==='source'||tokens.length||!noEmpty))commands.push(prefix.map(t=>t.split(replace).join(tokens.join(' '))));
 else if(tokens.length)for(let i=0;i<tokens.length;i+=n)commands.push([...prefix,...tokens.slice(i,i+n)]);
 if(!tokens.length&&!noEmpty&&(!replace||mode==='source'))commands.push([...prefix]);
 return {raw,tokens,commands,readLines:read.length,trace:[`Read ${read.length} lines; ${mode==='source'?'blank line terminates':'read to end, including blank lines'}.`,`${raw.length} whitespace-delimited words.`,mode==='source'?'Apply archived regex ;&|><*?$() (not a character class).':'Apply the assignment character class [;&|><*?$()].',replace?'Replace the placeholder with all collected tokens (course-project convention).':`Batch at most ${n} new arguments per command.`,`${commands.length} argument vectors constructed. Preview only: no subprocess executed.`]};
}
export function newChat(){return {next:1,clients:[],registry:{},events:[],last:null};}
export function chat(state,action,mode='source'){
 let s={...state,clients:state.clients.map(c=>({...c,messages:[...c.messages]})),registry:{...state.registry},events:[...state.events],last:null};
 const event=t=>{s.events=[t,...s.events].slice(0,24);};
 if(action.type==='join'){
  const name=String(action.name||'').trim();if(!/^[A-Za-z][A-Za-z0-9_]{0,15}$/.test(name))throw Error('Use a 1–16 character ASCII name starting with a letter.');if(s.clients.filter(c=>c.active).length>=4)throw Error('This model supports four active clients.');
  if(mode==='reference'&&s.registry[name])throw Error('Reference model rejects duplicate usernames.');
  const id=s.next++;s.clients.push({id,name,active:true,messages:[]});s.registry[name]=id;event(`Accept socket ${id}; start ClientHandler-${id}; register ${name}.`);if(mode==='reference')for(const c of s.clients)if(c.active&&c.id!==id)c.messages.push(`${name} joined`);s.last={from:'client '+id,to:'server',text:'register '+name};
 }else{
  const c=s.clients.find(c=>c.id===action.id&&c.active);if(!c)throw Error('Select an active client.');
  if(action.type==='leave'){
   c.active=false;if(mode==='source'||s.registry[c.name]===c.id)delete s.registry[c.name];event(`${c.name}/${c.id} disconnects; remove registry entry.`);if(mode==='reference')for(const other of s.clients)if(other.active)other.messages.push(`${c.name} left`);s.last={from:c.name,to:'server',text:'close socket'};
  }else if(action.type==='send'){
   const text=String(action.text||'');if(!/^[\x20-\x7e]{1,160}$/.test(text))throw Error('Use 1–160 printable ASCII characters for this wire-behavior model.');let targets=[];
   for(const id of Object.values(s.registry)){const other=s.clients.find(c=>c.id===id);if(other?.active&&other.id!==c.id){other.messages.push(c.name+': '+text);targets.push(other.id);}}
   event(`${c.name}/${c.id} → server → [${targets.join(', ')}]; sender is excluded.`);s.last={from:c.name,to:targets.map(id=>'client '+id).join(', ')||'no registered peers',text};
  }else throw Error('Unknown chat action.');
 }
 return s;
}
const files={'/index.html':{type:'text/html',body:'<h1>Welcome to my web server!</h1>'},'/script.js':{type:'application/javascript',body:'console.log("Hello, World!");'},'/style.css':{type:'text/css',body:''},'/images/logo.png':{type:'image/png',body:''}};
export function http(line,mode='reference'){
 if(typeof line!=='string'||line.length>400)throw Error('Request line limited to 400 characters.');let status=200,reason='OK',type='text/html',body='',stages=['Accept connection','Read request line'],path='';
 const error=(code,message)=>{status=code;reason=message;body=`<h1>${code} ${message}</h1>`;};
 if(mode==='early'){
  body=line.includes('/hello')?'<h1>Hello, World!</h1>':line.includes('/goodbye')?'<h1>Goodbye, World!</h1>':'<h1>404 - Not Found</h1>';stages.push('Substring route selection','Always emits 200 OK in this archived handler');
 }else{
  const parts=line.split(' ');const method=parts[0];
  if(mode==='source'?!line.startsWith('GET'):method!=='GET')error(405,'Method Not Allowed');
  else if(parts.length<2||!parts[1]||(mode==='reference'&&!/^GET \/\S* HTTP\/1\.[01]$/.test(line)))error(400,'Bad Request');
  else{
   path=parts[1];stages.push('Parse target '+path);
   if(mode==='reference'){
    try{path=decodeURIComponent(path.split('?')[0]);}catch{error(400,'Bad Request');}
    const stack=[];if(status===200){let escapes=false;for(const seg of path.split('/')){if(seg==='..'){if(!stack.length)escapes=true;else stack.pop();}else if(seg&&seg!=='.')stack.push(seg);}path='/'+stack.join('/');if(escapes||path.includes('\\')||path.includes('\0'))error(403,'Forbidden');}
   }else if(path.startsWith('/../')){
    // Finite, fictitious filesystem witness for the String.startsWith boundary defect.
    if(path==='/../webroot-backup/notes.txt'){type='text/plain';body='DEMO sibling file: outside webroot';stages.push('String prefix check incorrectly accepts /demo/webroot-backup');}
    else error(403,'Forbidden');
   }
   if(status===200&&!body){if(path==='/')path='/index.html';const f=files[path];if(f){body=f.body;type=f.type;}else error(404,'Not Found');}
  }
 }
 const length=new TextEncoder().encode(body).length;stages.push(`Select ${status} ${reason}`,`Write ${length} body bytes`,'Close connection');return {status,reason,type,body,length,path,stages,raw:`HTTP/1.1 ${status} ${reason}\r\nContent-Type: ${type}${type.startsWith('text/')||type==='application/javascript'?'; charset=utf-8':''}\r\nContent-Length: ${length}\r\n${status===405?'Allow: GET\r\n':''}Connection: close\r\n\r\n${body}`,note:'Deterministic browser model with synthetic fixtures. Body markup is displayed as text. No socket, request, filesystem access or TLS handshake occurs.'};
}
export function subnet(ip,prefix){if(!Number.isInteger(prefix)||prefix<0||prefix>32)throw Error('Prefix must be 0–32.');const octets=ip.trim().split('.');if(octets.length!==4||octets.some(p=>!/^\d{1,3}$/.test(p)||+p>255))throw Error('Enter four decimal octets, each 0–255.');const value=octets.reduce((a,b)=>(a*256+ +b)>>>0,0),mask=prefix?(-1<<(32-prefix))>>>0:0,network=(value&mask)>>>0,broadcast=(network|(~mask))>>>0;const dotted=n=>[24,16,8,0].map(s=>(n>>>s)&255).join('.');return {ip:octets.map(Number).join('.'),prefix,mask:dotted(mask),network:dotted(network),broadcast:dotted(broadcast),addresses:2**(32-prefix),traditionalHosts:prefix<=30?2**(32-prefix)-2:null,bits:value.toString(2).padStart(32,'0'),note:prefix===31?'/31 point-to-point semantics can use both addresses; no traditional network/broadcast host subtraction.':prefix===32?'/32 identifies one address (a host route).':'Traditional IPv4 subnet host count excludes network and broadcast.'};}
export function delays(bytes,mbps,km){if(![bytes,mbps,km].every(Number.isFinite)||bytes<1||bytes>1e6||mbps<1||mbps>10000||km<0||km>40000)throw Error('Invalid teaching parameters.');const transmission=bytes*8/(mbps*1e6)*1000,propagation=km*1000/2e8*1000;return {transmission,propagation,total:transmission+propagation};}
