export type EventRecord={id:string;title:string;description:string;date:string;time:string;category:string;capacity:number;joined:boolean;cancelled:boolean};
export type DemoState={events:EventRecord[];feedback:{id:number;eventId:string;eventTitle:string;text:string}[];nextId:number;log:string[]};
export const categories:string[];
export function initialState():DemoState;
export function transition(state:DemoState,action:{type:string;id?:string;values?:any;text?:string},role:string):DemoState;
export function filterEvents(events:EventRecord[],filters?:{query?:string;category?:string;date?:string;joinedOnly?:boolean}):EventRecord[];
export function contractTrace(options?:{routeAligned?:boolean;keysAligned?:boolean;schemaAligned?:boolean}):{layer:string;pass:boolean;before:string;after:string;reason:string}[];
