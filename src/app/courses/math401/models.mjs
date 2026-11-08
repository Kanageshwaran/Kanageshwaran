export const sum=(fn,a,b)=>{let s=0;for(let n=a;n<=b;n++)s+=fn(n);return s;};
export function integrate(fn,a,b,n=600){if(a===b)return 0;const h=(b-a)/n;let s=fn(a)+fn(b);for(let i=1;i<n;i++)s+=(i%2?4:2)*fn(a+i*h);return s*h/3;}
export const fraction=x=>x*(3-5*x)/((3*x-1)*(x-1)**2);
export const parts=x=>-x/Math.tan(x)+Math.log(Math.sin(x));
export const repeat=x=>-x*x*Math.cos(x)+2*x*Math.sin(x)+2*Math.cos(x);
export const retake=x=>-2*Math.sqrt(x)*Math.cos(Math.sqrt(x))+2*Math.sin(Math.sqrt(x));
export const alt=n=>n*n/Math.sqrt(n**5-n+5);
export function newton(n){let a=2;const terms=[a];for(let i=1;i<n;i++){a=(a+2/a)/2;terms.push(a);}return terms;}
export function model(id,v,degree=5){switch(id){
case 'area1':return {value:1.5*v*v-v**3/3,total:4.5};
case 'area2':return {value:3*v+v*v-v**3/3+5/3,total:32/3};
case 'area3':return {value:3*v-v*v-v**3/3+9,total:32/3};
case 'washer':return {value:Math.PI*Math.abs((4-v*v)**2-(v**3+2)**2),total:Math.PI*(integrate(x=>(4-x*x)**2-(x**3+2)**2,0,1)+integrate(x=>(x**3+2)**2-(4-x*x)**2,1,2))};
case 'shell':return {value:2*Math.PI*(4-v)*(6*v-v*v-8),total:8*Math.PI/3};
case 'parts':return {value:parts(v),total:v/Math.sin(v)**2};
case 'repeat':return {value:repeat(v),total:v*v*Math.sin(v)};
case 'fraction':return {value:fraction(v),total:-2/(v-1)-1/(v-1)**2+1/(3*v-1)};
case 'logtrig':return {value:-Math.cos(v)*Math.log(Math.cos(v))+Math.cos(v)-1,total:(Math.log(2)-1)/2};
case 'trigsub':return {value:Math.sin(v)/7,total:Math.cos(v)};
case 'retake':return {value:retake(v),total:Math.sin(Math.sqrt(v))};
case 'improper':return {value:Math.log(Math.log(v)),total:Infinity};
case 'arc':return {value:integrate(y=>Math.hypot(1,1/(2*Math.sqrt(y))-2),1,v),total:integrate(y=>Math.hypot(1,1/(2*Math.sqrt(y))-2),1,4)};
case 'ellipse':return {value:3*Math.sin(v)-1,total:Math.cos(v)/2};
case 'spiral':return {value:Math.SQRT2*Math.expm1(v),total:Math.exp(v)};
case 'polar':return {value:3*Math.cos(v),total:1+Math.cos(v)};
case 'newton':return {value:newton(v).at(-1),total:Math.SQRT2};
case 'geometric':return {value:sum(n=>(7/4)**n,3,v+2),total:(7/4)**(v+2)};
case 'pseries':return {value:sum(n=>n**(-.6),1,v),total:v**(-.6)};
case 'logseries':return {value:sum(n=>1/(n*Math.log(n)**2),2,v),total:1/Math.log(v)};
case 'alternating':return {value:sum(n=>(n%2?1:-1)*alt(n),1,v),total:alt(v+1)};
case 'power':return {value:sum(n=>v**(3*n),0,degree),total:1/(1-v**3)};
case 'centroid':return {value:Math.exp(v)+Math.exp(-v)-2,total:.5};
case 'cardioid':return {value:1-Math.cos(v),total:1.5*Math.PI};
default:throw Error('Unknown exhibit');}}
