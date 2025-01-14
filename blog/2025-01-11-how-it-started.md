# The Beginnings of Harmony Framework

## Introduction

## Where did it started and what did evolved ?

Harmony Framework is a new Roblox framework I've been using internally for years. In its early stages, it was simply a set of libraries called Melody. However, as my projects grew, I realized my code had significant flaws, even with the libraries making things easier.

Global RemoteEvents weren’t typed and were poorly optimized. Global state management was also untyped, relying on ValueBase objects. RemoteEvents were untyped, inter-script communication used BindableEvents with major issues, and managing replicated player data was done with Attributes, which are very bandwidth-expensive. And on top of the cake, my code was not consistent at all.

Giving myself too much freedom on how to write code was the top of the cake.
Inconsistencies everywheres, scripts parented in unusual places, questionnable naming conventions.
I needed some sort of constraint to keep myself from rewriting the entire code every week.

At that point, I moved away from Melody Framework and started using RobloxTS, but it had its own set of issues. I needed quick development, and RobloxTS or Rojo tools didn’t fit the project’s conditions, so using Flamework wasn’t ideal. Knit was unmaintained (I think?), and it wasn't type-safe. Prvd m' Wrong is still in early development and didn’t meet my needs.

## The goals of this new framework

After finishing a Roblox project without any framework and seeing the resulting Experience not finding any audience, I've gained experience and thought for myself "How can I not redo those mistakes ?". I thought of what a front-page game need and wrote these specifications:

- Luau comfortable libraries that can be used in reactive context (Like Fusion or ReactLua)
- Admin commands
- Detect exploits, cheats, authorize player actions like teleporting
- Safe, Typed & Fast Client-Server communication
- Manage global state
- Manage, save, react and replicate player state
- Use module architecture and have a better syntax that current Luau OOP syntax.
- Providers & Components
- Utility modules
- Easy debugging and inspecting of behaviours while in-game
- Be able to write some Scripts and LocalScripts that depends on Providers & Compoents, even if most of the code is SSA.
- Not forced to use Rojo

# Designing the framework

At first, I wasn't familiar with Wally and toolchains manager like aftman, foreman and rokit. (Just learned yesterday that Rokit must be used)
