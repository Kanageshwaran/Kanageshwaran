function finite(raw,label,min=-1e12,max=1e12){
 const text=String(raw).trim();if(!/^[+-]?(?:\d+\.?\d*|\.\d+)(?:[eE][+-]?\d+)?$/.test(text))throw Error(`Enter a valid number for ${label}.`);
 const n=Number(text);if(!Number.isFinite(n)||n<min||n>max)throw Error(`${label} must be between ${min} and ${max}.`);return n;
}
export function calculate(x,y,op){
 const a=finite(x,'x'),b=finite(y,'y');let result;
 if(op==='+')result=a+b;else if(op==='-')result=a-b;else if(op==='*')result=a*b;else if(op==='/'){if(b===0)throw Error("Can't divide by zero!");result=a/b;}else throw Error('Unknown operation.');
 if(!Number.isFinite(result))throw Error('Result is outside the supported numeric range.');
 return {a,b,result,text:`x ${op} y = ${Number(result.toPrecision(12))}`};
}
export function paycheck(kind,rate,hours){
 const pay=finite(rate,'pay rate',0,1e7),h=finite(hours,'hours worked',0,168);
 if(kind==='hourly')return {regular:Math.min(h,40)*pay,overtime:Math.max(h-40,0)*pay*1.5,total:Math.min(h,40)*pay+Math.max(h-40,0)*pay*1.5,method:'HourlyEmployee.computePay'};
 if(kind==='salaried')return {regular:pay/52,overtime:0,total:pay/52,method:'SalariedEmployee.computePay'};
 throw Error('Unknown employee type.');
}
function cents(raw,min=0){const t=String(raw).trim();if(!/^\d+(\.\d{1,2})?$/.test(t))throw Error('Use a nonnegative amount with at most two decimal places.');const n=Math.round(Number(t)*100);if(!Number.isSafeInteger(n)||n<min||n>100000000)throw Error('Amount is outside the demo limit ($1,000,000).');return n;}
export function bankAction(state,action){
 let accounts=state.accounts.map(x=>({...x})),capacity=state.capacity,message='';
 const find=()=>{const i=accounts.findIndex(x=>x.id===action.id);if(i<0)throw Error('Choose an existing account.');return i;};
 if(action.type==='open'){
  const id=String(action.id).trim();if(!/^\d{1,6}$/.test(id))throw Error('Use a demo account number of 1–6 digits.');if(accounts.some(a=>a.id===id))throw Error('Account number already exists.');if(accounts.length>=8)throw Error('This demo holds at most eight accounts.');
  const balance=cents(action.amount,100);if(accounts.length===capacity)capacity*=2;accounts.push({id,balance});message=`Opened ${id}; ${accounts.length} active references in ${capacity} slots.`;
 }else if(action.type==='deposit'||action.type==='withdraw'){
  const i=find(),amount=cents(action.amount,1);if(action.type==='withdraw'&&amount>accounts[i].balance)throw Error('Insufficient demo balance.');
  const balance=accounts[i].balance+(action.type==='deposit'?amount:-amount);if(balance>100000000)throw Error('Balance exceeds the demo limit.');accounts[i].balance=balance;message=`${action.type==='deposit'?'Deposited':'Withdrew'} ${(amount/100).toFixed(2)} for ${action.id}.`;
 }else if(action.type==='close'){
  const i=find(),last=accounts.length-1;message=i===last?`Clear slot ${i}; decrement count.`:`Move the last reference (${accounts[last].id}) into slot ${i}; clear slot ${last}; decrement count.`;
  accounts[i]=accounts[last];accounts.pop();
 }else throw Error('Unknown bank action.');
 return {accounts,capacity,message};
}
