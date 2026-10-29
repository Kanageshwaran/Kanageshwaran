export type Vehicle = {model:string;manufacturer:string;cylinders:number;engine:number;cost:number};
export function parseVehicle(input:Record<string,string>,count?:number):Vehicle;
export function matrixStats(data:number[][],row:number,col:number):{total:number;average:number;rowTotal:number;columnTotal:number;highest:number;lowest:number};
export function digitTrace(raw:string):{index:number;character:string;isDigit:boolean;digit:number;sum:number}[];
