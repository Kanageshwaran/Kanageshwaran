export function calculate(x:string|number,y:string|number,op:string):{a:number;b:number;result:number;text:string};
export function paycheck(kind:string,rate:string|number,hours:string|number):{regular:number;overtime:number;total:number;method:string};
export type BankState={accounts:{id:string;balance:number}[];capacity:number;message:string};
export function bankAction(state:BankState,action:{type:string;id:string;amount?:string}):BankState;
