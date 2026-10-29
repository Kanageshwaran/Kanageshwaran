export function byteValue(raw: string|number): {unsigned:number;signed:number;binary:string;hex:string};
export function alu(op:string,left:string|number,right:string|number): ReturnType<typeof byteValue> & {carry:boolean|null;overflow:boolean|null;sign:boolean;zero:boolean;less:boolean|null};
export function insertionTrace(values:number[]): {message:string;depth:number;active:number;head:number|null;nodes:{id:number;value:number;next:number|null}[]}[];
