export type ProcessFrame={title:string;code:string;main:string;t1:string;t2:string;child1:string;child2:string;heap:string;output:string[];note:string};
export function processTrace(first?:string,last?:string,exitCode?:number):ProcessFrame[];
export function swapModel(names:string[],referenceSwap?:boolean,contentSwap?:boolean):{buffers:string[];pointers:number[];values:string[]};
export function tokenizeClasses(text:string):{tokens:string[];bytes:string[];note:string};
