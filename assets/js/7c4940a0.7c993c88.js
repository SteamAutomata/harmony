"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[9935],{85334:(e,n,s)=>{s.r(n),s.d(n,{assets:()=>l,contentTitle:()=>r,default:()=>m,frontMatter:()=>a,metadata:()=>o,toc:()=>c});const o=JSON.parse('{"id":"Examples","title":"Examples","description":"Kill brick","source":"@site/docs/6.Examples.md","sourceDirName":".","slug":"/Examples","permalink":"/harmony/docs/Examples","draft":false,"unlisted":false,"editUrl":"https://github.com/steamautomata/harmony/edit/main/docs/6.Examples.md","tags":[],"version":"current","sidebarPosition":6,"frontMatter":{"sidebar_position":6},"sidebar":"defaultSidebar","previous":{"title":"Providers","permalink":"/harmony/docs/Providers"},"next":{"title":"Conventions","permalink":"/harmony/docs/More/NamingConventions"}}');var t=s(74848),i=s(28453);const a={sidebar_position:6},r="Examples",l={},c=[{value:"Kill brick",id:"kill-brick",level:2},{value:"Money Service",id:"money-service",level:2},{value:"Make a custom health system",id:"make-a-custom-health-system",level:2}];function d(e){const n={a:"a",code:"code",h1:"h1",h2:"h2",header:"header",p:"p",...(0,i.R)(),...e.components};return(0,t.jsxs)(t.Fragment,{children:[(0,t.jsx)(n.header,{children:(0,t.jsx)(n.h1,{id:"examples",children:"Examples"})}),"\n",(0,t.jsx)(n.h2,{id:"kill-brick",children:"Kill brick"}),"\n",(0,t.jsx)(n.p,{children:"The simplest example of creating a killbrick, cleaning itself up if the tag is removed."}),"\n",(0,t.jsx)(n.p,{children:"-# wip"}),"\n",(0,t.jsx)(n.h2,{id:"money-service",children:"Money Service"}),"\n",(0,t.jsx)(n.p,{children:"This is an example for a service handling player currencies. Obviously, clients can't access Providers on the server, so we would need to use the player state!"}),"\n",(0,t.jsx)(n.p,{children:"-# wip"}),"\n",(0,t.jsx)(n.h2,{id:"make-a-custom-health-system",children:"Make a custom health system"}),"\n",(0,t.jsx)(n.p,{children:"When making a combat game, you would want to apply armors, apply effects like poison or withering."}),"\n",(0,t.jsxs)(n.p,{children:["Using components, you can add extra behaviors to ",(0,t.jsx)(n.code,{children:"Humanoid"}),", and instead of using ",(0,t.jsx)(n.code,{children:"Humanoid:TakeDamage(number)"}),", you will use ",(0,t.jsx)(n.code,{children:"HealthManager:TakeDamage(number, options)"})," and even ",(0,t.jsx)(n.code,{children:"HealthManager:Poison(damage, duration)"})," which will account armor points and modifiers!"]}),"\n",(0,t.jsxs)(n.p,{children:["For modifiers, we will use ",(0,t.jsx)(n.a,{href:"https://devforum.roblox.com/t/boost-dynamic-number-manipulation/2786416",children:"Boost"}),"! You can get it on the marketplace ",(0,t.jsx)(n.a,{href:"https://create.roblox.com/marketplace/asset/15931813099/Boost%3Fkeyword=&pageNumber=&pagePosition=",children:"here"}),"!"]}),"\n",(0,t.jsx)(n.p,{children:"-# wip"})]})}function m(e={}){const{wrapper:n}={...(0,i.R)(),...e.components};return n?(0,t.jsx)(n,{...e,children:(0,t.jsx)(d,{...e})}):d(e)}},28453:(e,n,s)=>{s.d(n,{R:()=>a,x:()=>r});var o=s(96540);const t={},i=o.createContext(t);function a(e){const n=o.useContext(i);return o.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function r(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(t):e.components||t:a(e.components),o.createElement(i.Provider,{value:n},e.children)}}}]);