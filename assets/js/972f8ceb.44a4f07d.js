"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[3185],{36795:e=>{e.exports=JSON.parse('{"archive":{"blogPosts":[{"id":"/2025/01/11/how-it-started","metadata":{"permalink":"/harmony/blog/2025/01/11/how-it-started","editUrl":"https://github.com/steamautomata/harmony/edit/main/blog/2025-01-11-how-it-started.md","source":"@site/blog/2025-01-11-how-it-started.md","title":"The Beginnings of Harmony Framework","description":"Introduction","date":"2025-01-11T00:00:00.000Z","tags":[],"readingTime":1.99,"hasTruncateMarker":false,"authors":[],"frontMatter":{},"unlisted":false},"content":"## Introduction\\r\\n\\r\\n## Where did it started and what did evolved ?\\r\\n\\r\\nHarmony Framework is a new Roblox framework I\'ve been using internally for years. In its early stages, it was simply a set of libraries called Melody. However, as my projects grew, I realized my code had significant flaws, even with the libraries making things easier.\\r\\n\\r\\nGlobal RemoteEvents weren\u2019t typed and were poorly optimized. Global state management was also untyped, relying on ValueBase objects. RemoteEvents were untyped, inter-script communication used BindableEvents with major issues, and managing replicated player data was done with Attributes, which are very bandwidth-expensive. And on top of the cake, my code was not consistent at all.\\r\\n\\r\\nGiving myself too much freedom on how to write code was the top of the cake.\\r\\nInconsistencies everywheres, scripts parented in unusual places, questionnable naming conventions.\\r\\nI needed some sort of constraint to keep myself from rewriting the entire code every week.\\r\\n\\r\\nAt that point, I moved away from Melody Framework and started using RobloxTS, but it had its own set of issues. I needed quick development, and RobloxTS or Rojo tools didn\u2019t fit the project\u2019s conditions, so using Flamework wasn\u2019t ideal. Knit was unmaintained (I think?), and it wasn\'t type-safe. Prvd m\' Wrong is still in early development and didn\u2019t meet my needs.\\r\\n\\r\\n## The goals of this new framework\\r\\n\\r\\nAfter finishing a Roblox project without any framework and seeing the resulting Experience not finding any audience, I\'ve gained experience and thought for myself \\"How can I not redo those mistakes ?\\". I thought of what a front-page game need and wrote these specifications:\\r\\n\\r\\n- Luau comfortable libraries that can be used in reactive context (Like Fusion or ReactLua)\\r\\n- Admin commands\\r\\n- Detect exploits, cheats, authorize player actions like teleporting\\r\\n- Safe, Typed & Fast Client-Server communication\\r\\n- Manage global state\\r\\n- Manage, save, react and replicate player state\\r\\n- Use module architecture and have a better syntax that current Luau OOP syntax.\\r\\n- Providers & Components\\r\\n- Utility modules\\r\\n- Easy debugging and inspecting of behaviours while in-game\\r\\n- Be able to write some Scripts and LocalScripts that depends on Providers & Compoents, even if most of the code is SSA.\\r\\n- Not forced to use Rojo\\r\\n\\r\\n# Designing the framework\\r\\n\\r\\nAt first, I wasn\'t familiar with Wally and toolchains manager like aftman, foreman and rokit. (Just learned yesterday that Rokit must be used)"}]}}')}}]);