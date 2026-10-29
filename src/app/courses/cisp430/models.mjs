export function listSteps(text){
 if(typeof text!=='string'||text.length>10000)throw Error('Use at most 10,000 characters.');
 const lines=text.split(/\r?\n/).map(s=>s.trim()).filter(Boolean);
 if(lines.length>80)throw Error('Use at most 80 commands.');
 let head=null,tail=null,nextId=1;const steps=[{nodes:[],message:'Empty list: head = tail = null.'}];
 for(const line of lines){
  const deleting=line.startsWith('delete'),name=deleting?line.slice(6).trim():line;
  if(!name||name.length>40||!/^[\x20-\x7e]+$/.test(name))throw Error('Use printable ASCII names of 1–40 characters.');
  let message;
  if(deleting){let cur=head;while(cur&&cur.name!==name)cur=cur.next;
   if(cur){if(cur.prev)cur.prev.next=cur.next;else head=cur.next;if(cur.next)cur.next.prev=cur.prev;else tail=cur.prev;message=`Delete ${name}: reconnect neighbors and update head/tail.`;}else message=`Delete ${name}: no matching node; list unchanged.`;
  }else{
   const node={id:nextId++,name,prev:null,next:null};
   if(!head){head=tail=node;}
   else if(name<=head.name){node.next=head;head.prev=node;head=node;}
   else if(name>=tail.name){node.prev=tail;tail.next=node;tail=node;}
   else{let cur=head;while(cur&&cur.name<name)cur=cur.next;node.prev=cur.prev;node.next=cur;cur.prev.next=node;cur.prev=node;}
   message=`Insert ${name}: preserve case-sensitive sorted order.`;
  }
  const nodes=[];for(let cur=head;cur;cur=cur.next)nodes.push({id:cur.id,name:cur.name,prev:cur.prev?.id??null,next:cur.next?.id??null});
  steps.push({nodes,message});
 }
 const names=steps.at(-1).nodes.map(n=>n.name);return {steps,output:[...names,'=============',...names.slice().reverse()].join('\n')+'\n'};
}
export function graphSteps(text){
 if(typeof text!=='string'||text.length>10000)throw Error('Use at most 10,000 characters.');
 const tokens=text.trim().split(/\s+/);if(tokens.some(t=>!/^\d+(?:\.\d+)?$/.test(t)))throw Error('Use nonnegative numeric tokens only.');
 const a=tokens.map(Number),[n,m]=a;
 if(!Number.isInteger(n)||n<1||n>12||!Number.isInteger(m)||m<0||m>50)throw Error('Use 1–12 vertices and 0–50 edges.');
 if(a.length!==3*m+3)throw Error('Expected n m, m lines of u v weight, then start vertex.');
 const edges=[],adj=Array.from({length:n},()=>[]);
 for(let i=0;i<m;i++){const [u,v,w]=a.slice(2+3*i,5+3*i);if(!Number.isInteger(u)||!Number.isInteger(v)||u<0||v<0||u>=n||v>=n||!Number.isFinite(w)||w>1000000)throw Error('Edge endpoints must be valid integers and weights at most 1,000,000.');edges.push({u,v,w});adj[u].push({v,w});adj[v].push({v:u,w});}
 const start=a.at(-1);if(!Number.isInteger(start)||start<0||start>=n)throw Error('Invalid start vertex.');
 const dist=Array(n).fill(Infinity),pred=Array(n).fill(-1),visited=Array(n).fill(false),queue=[],steps=[];dist[start]=0;queue.push([0,start]);
 const snapshot=(message,current)=>steps.push({dist:[...dist],pred:[...pred],visited:[...visited],current,message});snapshot('Initialize the source distance to zero.',null);
 while(queue.length){queue.sort((x,y)=>x[0]-y[0]||x[1]-y[1]);const [d,u]=queue.shift();if(visited[u])continue;visited[u]=true;const changes=[];
  for(const {v,w} of adj[u])if(!visited[v]&&d+w<dist[v]){dist[v]=d+w;pred[v]=u;queue.push([dist[v],v]);changes.push(`${u} → ${v}: ${dist[v]}`);}
  snapshot(`Settle vertex ${u}.${changes.length?' Relax '+changes.join('; '):' No distance improved.'}`,u);
 }
 const paths=dist.map((d,v)=>{if(!Number.isFinite(d))return [];const path=[];for(let cur=v;cur!==-1;cur=pred[cur]){path.push(cur);if(cur===start)break;}return path.reverse();});
 return {n,edges,start,steps,dist,pred,paths};
}
