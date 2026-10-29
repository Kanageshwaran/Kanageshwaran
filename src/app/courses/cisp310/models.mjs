export function byteValue(raw) {
 const text=String(raw).trim();
 if(!/^\d+$/.test(text) || Number(text)>255) throw Error('Enter a whole number from 0 to 255.');
 const value=Number(text);
 return {unsigned:value,signed:value<128?value:value-256,binary:value.toString(2).padStart(8,'0'),hex:value.toString(16).toUpperCase().padStart(2,'0')};
}
export function alu(op,left,right) {
 const a=byteValue(left).unsigned,b=op==='not'?0:byteValue(right).unsigned;
 let full,result,carry=null,overflow=null;
 if(op==='add') {full=a+b;result=full&255;carry=full>255;overflow=!!((~(a^b)&(a^result)&128));}
 else if(op==='sub') {full=a-b;result=full&255;carry=a<b;overflow=!!(((a^b)&(a^result)&128));}
 else if(op==='and') result=a&b;
 else if(op==='or') result=a|b;
 else if(op==='not') result=(~a)&255;
 else throw Error('Unsupported operation');
 const sign=!!(result&128),zero=result===0;
 return {...byteValue(result),carry,overflow,sign,zero,less:overflow===null?null:sign!==overflow};
}
// Semantic visualization of the supplied C algorithm; not execution of TTP assembly.
export function insertionTrace(values) {
 if(!Array.isArray(values)||values.length>8) throw Error('Use at most eight values.');
 values.forEach(byteValue);
 const nodes=values.map((value,id)=>({id,value,next:null}));let head=null;const frames=[];
 const snapshot=(message,depth,active)=>frames.push({message,depth,active,head,nodes:nodes.map(n=>({...n}))});
 function insert(owner,id,depth) {
  const current=owner===null?head:nodes[owner].next;
  snapshot(`Depth ${depth}: inspect ${owner===null?'head':`node ${owner}'s next pointer`}.`,depth,id);
  if(current===null||nodes[current].value>nodes[id].value) {
   nodes[id].next=current;
   if(owner===null)head=id;else nodes[owner].next=id;
   snapshot(`Insert ${nodes[id].value}: connect its next pointer, then update the incoming pointer.`,depth,id);
  } else {snapshot(`${nodes[current].value} ≤ ${nodes[id].value}: recurse through the next pointer.`,depth,id);insert(current,id,depth+1);snapshot(`Return from depth ${depth+1}.`,depth,id);}
 }
 values.forEach((_,id)=>insert(null,id,0));return frames;
}
