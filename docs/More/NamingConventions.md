# Conventions

## Provider

A provider method name should be PascalCase and their properties camelCase.

Only use `Props` and `Methods` values inside your service.
`self` must never be used and methods must be pure functions, referencing `Props` or `Methods` if necessary.

Add a `_` for private Props & Methods.
It seems unnecessary to put private fields in Props & Methods, but it may be useful for debugging using Iris.

A base Harmony provider with a counter should look like this:

```lua
--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Harmony = require(ReplicatedStorage.Harmony)

-- Properties
local Props = {
    counter = 0,
    _privateProperty = 16
}

-- Methods
local Methods = {}

function Methods.IncreaseCounter()
    Props.counter += 1
    Methods.Print()
end

function Methods.Print()
    print(Props.counter)
end

-- Lifecycles
function onInit()

end

function onInit()

end

-- Footer
local self = Harmony.Provider.new(script.Name, Methods, Props)
Harmony.Workers.OnInit:Connect(self, onInit)
Harmony.Workers.OnStart:Connect(self, onInit)
return self
```
