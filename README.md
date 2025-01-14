# Harmony Framework

## A bloated but battery-included framework!

Keep It Simple & Smart! No fancy `import("YourService")` function that breaks Luau types.
Just `require` it!

### TODO

Harmony isn't finished yet, checklist:

- [x] Providers
- [ ] Components
- [ ] More lifecycles
- [ ] Global State Management
- [ ] Player State Management
- [ ] Component & Service & value telemetry
- [ ] Iris Integration

### The goals:

- Manage to work around Luau typings while keeping the code readable
- Be as complete as possible
- Make use of third party libraries
- Diagnose bugs easily

### Features:

- Guarantee Luau types
- Replicated Global & Player State management
- Providers (Equivalent of Services and Controllers)
- Components
- Events (Equivalent of Lifecycles in Flamework)

### Dependencies:

- ByteNet
- Iris
- Signal
- Janitor

# Using Harmony

The Roblox Studio plugin is optional. It provides a quick way to create Providers & Components

# Why Harmony ?

Because not Melody!

# Flaws & Drawbacks

As it uses Single Script Architecture, it is not recommended to use `Actor` as it creates more Luau VMs and you will end up with two Singletons instead of one as expected.

No other drawbacks are found from using this framework yet, except that it hasn't been battle tested yet.
