export function parseVehicle(input,count=0){
 if(count>=20)throw Error('The collection holds at most 20 vehicles.');
 const model=String(input.model).trim(),manufacturer=String(input.manufacturer).trim();
 if(!model||model.length>24)throw Error('Model must contain 1–24 characters.');
 if(!manufacturer||manufacturer.length>15)throw Error('Manufacturer must contain 1–15 characters.');
 if(!/^\d+$/.test(String(input.cylinders)))throw Error('Cylinders must be a whole number from 1 to 12.');
 const cylinders=Number(input.cylinders);if(cylinders<1||cylinders>12)throw Error('Cylinders must be from 1 to 12.');
 function numeric(raw,label,min,max){if(!String(raw).trim())throw Error(`${label} is required.`);const n=Number(raw);if(!Number.isFinite(n)||n<min||n>max)throw Error(`${label} must be from ${min} to ${max}.`);return n;}
 return {model,manufacturer,cylinders,engine:numeric(input.engine,'Engine displacement',0.1,20),cost:numeric(input.cost,'Cost',0,250000)};
}
export function matrixStats(data,row,col){
 if(data.length!==5||data.some(r=>r.length!==20||r.some(v=>!Number.isSafeInteger(v))))throw Error('Use a 5 by 20 integer matrix.');
 if(!Number.isInteger(row)||row<0||row>4||!Number.isInteger(col)||col<0||col>19)throw Error('Invalid row or column.');
 const total=data.flat().reduce((a,b)=>a+b,0);if(!Number.isSafeInteger(total))throw Error('Matrix total is outside the safe integer range.');
 return {total,average:total/100,rowTotal:data[row].reduce((a,b)=>a+b,0),columnTotal:data.reduce((a,b)=>a+b[col],0),highest:Math.max(...data[row]),lowest:Math.min(...data[row])};
}
export function digitTrace(raw){
 const text=String(raw);if(!text||text.length>24||!/^[\x21-\x7E]+$/.test(text))throw Error('Enter 1–24 printable ASCII characters without spaces.');
 let sum=0;return [...text].map((character,index)=>{const digit=/[0-9]/.test(character)?Number(character):0;sum+=digit;return {index,character,isDigit:/[0-9]/.test(character),digit,sum};});
}
