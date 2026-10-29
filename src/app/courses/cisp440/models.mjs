export const vertices=['a','b','c','x'];
export const edges=[{u:'a',v:'x',w:10},{u:'a',v:'b',w:3},{u:'a',v:'c',w:5},{u:'b',v:'c',w:1},{u:'c',v:'x',w:3}];
const exact={a:7,b:4,c:3,x:0};
export function astarTrace(heuristics,reopen=true){
 const h={};for(const v of vertices){const s=String(heuristics[v]).trim();if(!/^\d+(?:\.\d+)?$/.test(s)||!Number.isFinite(+s)||+s>30)throw Error('Each heuristic must be a number from 0 to 30.');h[v]=+s;}if(h.x!==0)throw Error('Use h(x) = 0 for this goal.');
 const g={a:0,b:Infinity,c:Infinity,x:Infinity},prev={a:null,b:null,c:null,x:null},open=new Set(['a']),closed=new Set(),frames=[];
 const record=(message,current)=>frames.push({g:{...g},f:Object.fromEntries(vertices.map(v=>[v,g[v]+h[v]])),prev:{...prev},open:[...open],closed:[...closed],current,message});record('Initialize: open = {a}, g(a) = 0.',null);
 while(open.size){const u=[...open].sort((a,b)=>(g[a]+h[a])-(g[b]+h[b])||a.localeCompare(b))[0];open.delete(u);
  if(u==='x'){record('Select goal x and reconstruct the predecessor path.',u);break;}
  closed.add(u);const messages=[];
  for(const e of edges.filter(e=>e.u===u)){const candidate=g[u]+e.w;if(candidate>=g[e.v])continue;
   if(closed.has(e.v)&&!reopen){messages.push(`Skip cheaper ${e.v} because it is already closed.`);continue;}
   g[e.v]=candidate;prev[e.v]=u;if(closed.delete(e.v))messages.push(`Reopen ${e.v}.`);open.add(e.v);messages.push(`g(${e.v}) = ${candidate}, prev = ${u}.`);
  }
  record(`Expand ${u}. ${messages.join(' ')}`,u);
 }
 const path=[];if(Number.isFinite(g.x)){for(let v='x';v!==null;v=prev[v])path.push(v);path.reverse();}
 const inadmissible=vertices.filter(v=>h[v]>exact[v]),inconsistent=edges.filter(e=>h[e.u]>e.w+h[e.v]);
 return {frames,h,path,cost:g.x,inadmissible,inconsistent};
}
export function choose(n,k){if(!Number.isInteger(n)||!Number.isInteger(k)||n<0||k<0||k>n)return 0;let answer=1;for(let i=1;i<=Math.min(k,n-k);i++)answer=answer*(n-i+1)/i;return Math.round(answer);}
export function countOutcomes(pool,specialPool,matches,same){
 const vals=[pool,specialPool,matches].map(x=>String(x).trim());if(vals.some(x=>!/^\d+$/.test(x)))throw Error('Use whole numbers for the pools and match count.');
 const [n,m,k]=vals.map(Number);if(n<5||n>20||m<1||m>20||k<0||k>5)throw Error('Use an ordinary pool of 5–20, a special pool of 1–20 and 0–5 matches.');
 const matched=choose(5,k),unmatched=choose(n-5,5-k),special=same?1:m-1,total=choose(n,5)*m;
 return {matched,unmatched,special,count:matched*unmatched*special,total};
}
export function truthTable(op){if(!['and','or','implies','iff','nand'].includes(op))throw Error('Unknown operator.');return [false,true].flatMap(p=>[false,true].map(q=>({p,q,result:op==='and'?p&&q:op==='or'?p||q:op==='implies'?!p||q:op==='iff'?p===q:!(p&&q)})));}
export function setModel(a,b){
 const parse=s=>{if(s.trim()==='')return [];const tokens=s.split(',').map(t=>t.trim());if(tokens.length>20||tokens.some(t=>!/^[-+]?\d+$/.test(t)||Math.abs(Number(t))>100))throw Error('Use up to 20 comma-separated integers from −100 to 100.');return [...new Set(tokens.map(Number))].sort((x,y)=>x-y);};
 const A=parse(a),B=parse(b),intersection=A.filter(x=>B.includes(x)),union=[...new Set([...A,...B])].sort((x,y)=>x-y),difference=A.filter(x=>!B.includes(x));
 return {A,B,intersection,union,difference,all:A.every(x=>B.includes(x)),some:A.some(x=>B.includes(x)),counterexamples:difference};
}
