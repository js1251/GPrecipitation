DEFINE_BASECLASS("gp_spawner")
ENT.Type = "anim"
ENT.Category = "GPrecipitation Particles"
ENT.Spawnable = true
ENT.Author = "KingPommes"
ENT.PrintName = "Rain Spawner"

ENT.PrecipitationType = "rain"

AddCSLuaFile("gp_rain.lua")
