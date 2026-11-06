export function outcomes():{label:string,count:number}[];
export function inEvent(count:number,event:string):boolean;
export function binomial(n:number,p:number):number[];
export function binEvent(k:number,event:string):boolean;
export function normalCDF(z:number):number;
export function sampleMean(n:number):{se:number,z:number,p:number};
export function goodness():{observed:number[],expected:number[],contributions:number[],statistic:number,df:number,p:number};
