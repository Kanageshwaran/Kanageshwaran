export type Result={columns:string[];rows:(string|number|null)[][];sql?:string};
export const queryTitles:string[];
export const explanations:string[];
export function getTables(dataset?:string):Record<string,Result>;
export function querySQL(index:number,threshold?:number,grade?:number):string;
export function runQuery(dataset:string,index:number,threshold?:number,grade?:number):Result & {sql:string};
export function csv(result:Result):string;
export const algebraTasks:{title:string;expression:string;note:string}[];
export function algebra(index:number):Result & {employees:any[];projects:any[];work:any[];deps:any[]};
