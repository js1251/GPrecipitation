DEFINE_BASECLASS("base_anim")
ENT.Type = "anim"
ENT.Category = "GPrecipitation Particles"
ENT.Spawnable = false
ENT.Author = "KingPommes"
ENT.PrintName = "Base Spawner"

game.AddParticles("particles/gprecipitation.pcf")
PrecacheParticleSystem("rain")
PrecacheParticleSystem("snow")

ENT.PrecipitationType = "rain"

if SERVER then
    AddCSLuaFile("gp_spawner.lua")

    function ENT:SpawnFunction(ply, tr, ClassName)
        local ent = ents.Create(ClassName)
        ent:SetPos(tr.HitPos + Vector(0,0,512))
        local ang = ply:GetAngles()
        ang.p = 0
        ang.r = 0

        ent:SetAngles(ang)

        ent:SetModel("models/hunter/plates/plate5x5.mdl")
        ent:PhysicsInit(SOLID_VPHYSICS)
        ent:SetMoveType(MOVETYPE_VPHYSICS)
        ent:SetSolid(SOLID_VPHYSICS)

        ent:SetColor(Color(91,217,255,154))
        ent:SetRenderMode(RENDERMODE_TRANSCOLOR)
        ent:DrawShadow(false)

        local phys = ent:GetPhysicsObject()
        if not IsValid(phys) then return end

        phys:EnableMotion(false)

        ent:Spawn()
        ent:Activate()

        return ent
    end
else
    function ENT:Initialize()
        self.ParticleSystem = ParticleEffectAttach(self.PrecipitationType, PATTACH_ABSORIGIN_FOLLOW, self, 0)
    end

    function ENT:OnRemove()
        if IsValid(self.ParticleSystem) then
            self.ParticleSystem:StopEmission()
            self.ParticleSystem:Remove()
        end
    end
end
