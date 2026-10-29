export const vertices:string[];
export const edges:{u:string;v:string;w:number}[];
export type Frame={g:Record<string,number>;f:Record<string,number>;prev:Record<string,string|null>;open:string[];closed:string[];current:string|null;message:string};
export function astarTrace(h:Record<string,string|number>,reopen?:boolean):{frames:Frame[];h:Record<string,number>;path:string[];cost:number;inadmissible:string[];inconsistent:{u:string;v:string;w:number}[]};
export function choose(n:number,k:number):number;
export function countOutcomes(pool:string|number,specialPool:string|number,matches:string|number,same:boolean):{matched:number;unmatched:number;special:number;count:number;total:number};
export function truthTable(op:string):{p:boolean;q:boolean;result:boolean}[];
export function setModel(a:string,b:string):{A:number[];B:number[];intersection:number[];union:number[];difference:number[];all:boolean;some:boolean;counterexamples:number[]};
