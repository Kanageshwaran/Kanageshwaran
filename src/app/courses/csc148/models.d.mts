export function rng(seed?:number):()=>number;
export function randomSamples(seed?:number,n?:number):any;
export function fcfs(arrivals:number[],services:number[]):any[];
export function queueRun(mode?:string,seed?:number,n?:number):any;
export function population(jobs:any[],t:number):number;
export function stepPoints(records:any[],site:string,initial:number,end?:number):number[][];
export function snapshot(records:any[],index:number,restock?:boolean):number[];
export function poissonBins(lambda:number,n?:number,max?:number):number[];
