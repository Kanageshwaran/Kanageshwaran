export function outcomes(){return Array.from({length:16},(_,i)=>({label:i.toString(2).padStart(4,'0').replaceAll('0','F').replaceAll('1','T'),count:i.toString(2).replaceAll('0','').length}));}
export function inEvent(count,event){return event==='same'?count===0||count===4:event==='atMostOne'?count<=1:count===2;}
export function binomial(n,p){if(!Number.isInteger(n)||n<0||p<0||p>1)throw Error('Invalid binomial inputs');return Array.from({length:n+1},(_,k)=>{let c=1;for(let j=1;j<=k;j++)c=c*(n-j+1)/j;return c*p**k*(1-p)**(n-k);});}
export function binEvent(k,event){return event==='one'?k===1:event==='two'?k===2:event==='none'?k===0:k>4;}
// Abramowitz-Stegun erf approximation. Absolute CDF error < 1e-7 for this interface.
export function normalCDF(z){const sign=z<0?-1:1,x=Math.abs(z)/Math.SQRT2,t=1/(1+.3275911*x),erf=1-(((((1.061405429*t-1.453152027)*t)+1.421413741)*t-.284496736)*t+.254829592)*t*Math.exp(-x*x);return .5*(1+sign*erf);}
export function sampleMean(n){const se=5/Math.sqrt(n),z=(14-15)/se;return {se,z,p:normalCDF(z)};}
export function goodness(){const observed=[405,55,40],expected=[425,50,25],contributions=observed.map((o,i)=>(o-expected[i])**2/expected[i]),statistic=contributions.reduce((a,b)=>a+b,0);return {observed,expected,contributions,statistic,df:2,p:Math.exp(-statistic/2)};}
