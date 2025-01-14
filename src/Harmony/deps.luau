assert(script.Parent.Parent:FindFirstChild("Packages"), "Harmony requires ReplicatedStorage.Packages")
return require(script.Parent.Parent.Packages)