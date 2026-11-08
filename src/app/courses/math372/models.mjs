export function ellipsePoint(t,phi=0){const u=t*Math.PI/180,r=phi*Math.PI/180,X=4*Math.cos(u),Y=2*Math.sin(u),cos=Math.cos(r),sin=Math.sin(r),c=Math.sqrt(12),x=X*cos-Y*sin,y=X*sin+Y*cos,fx=c*cos,fy=c*sin;return {X,Y,x,y,c,focus1:[-fx,-fy],focus2:[fx,fy],d1:Math.hypot(x+fx,y+fy),d2:Math.hypot(x-fx,y-fy),cos,sin};}
export function rotatedCoefficients(phi){const r=phi*Math.PI/180,c=Math.cos(r),s=Math.sin(r);return {A:c*c+4*s*s,B:-6*c*s,C:s*s+4*c*c};}
export function construction(){const a=4,b=2,c=Math.sqrt(a*a-b*b),inches=(c-Math.floor(c))*12;return {a,b,c,string:2*a,width:2*a,height:2*b,feet:Math.floor(c),inches,nearestSixteenth:Math.round(inches*16)/16};}
export function sequence(kind,n){if(!Number.isInteger(n)||n<1||n>100)throw Error('Term index outside 1–100');return kind==='geometric'?-8*Math.pow(.5,n-1):11-3*(n-1);}
export function correctedSystem(){return {x:50/11,y:-12/11};}
export function partialFractions(x){if(x===0||x===1||x===-3)throw Error('Outside the domain');return {original:(7*x-3)/(x*x*x+2*x*x-3*x),corrected:1/x+1/(x-1)-2/(x+3),recorded:-1/x+2.5/(x-1)-1.5/(x+3)};}
