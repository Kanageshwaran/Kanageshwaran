export type ListNode={id:number;name:string;prev:number|null;next:number|null};
export function listSteps(text:string):{steps:{nodes:ListNode[];message:string}[];output:string};
export type GraphStep={dist:number[];pred:number[];visited:boolean[];current:number|null;message:string};
export type GraphResult={n:number;edges:{u:number;v:number;w:number}[];start:number;steps:GraphStep[];dist:number[];pred:number[];paths:number[][]};
export function graphSteps(text:string):GraphResult;
