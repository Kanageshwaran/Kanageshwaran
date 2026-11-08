export const cubic=x=>x*x*x-6*x*x+5;
export const derivative=x=>3*x*x-12*x;
export const secondDerivative=x=>6*x-12;
export const primitive=x=>x**4/4-2*x**3+5*x;
export function secant(h,a=1){if(h===0||!Number.isFinite(h))return null;return 3*a*a-12*a+(3*a-6)*h+h*h;}
export function candidates(){return [-3,0,4,5].map(x=>({x,y:cubic(x),kind:x===-3?'Absolute minimum':x===0?'Absolute maximum':x===4?'Local minimum':'Right endpoint'}));}
export function riemann(n,method='midpoint'){if(!Number.isInteger(n)||n<1||n>1000)throw Error('Invalid rectangle count');const width=2/n,offset=method==='left'?0:method==='right'?1:.5,rectangles=Array.from({length:n},(_,i)=>{const left=i*width,sample=left+offset*width;return {left,width,sample,height:cubic(sample)};});return {rectangles,sum:rectangles.reduce((a,r)=>a+r.width*r.height,0),exact:primitive(2)-primitive(0)};}
export function holeValue(x,filled=false){if(x===-5)return null;if(x===5)return filled ? 0.4 : null;return (x-1)/(x+5);}
export function rectangle(x){if(x<0||!Number.isFinite(x))throw Error('Width must be nonnegative');const height=2**(-x),optimalX=1/Math.LN2;return {width:x,height,area:x*height,optimalX,optimalHeight:1/Math.E,optimalArea:1/(Math.E*Math.LN2)};}
