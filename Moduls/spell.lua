local addonName, addon = ...

addon.spell = {}
addon.__index = spell

function addon:newSpell(name, ids, roles)
   local sp = {}            
   setmetatable(sp,spell)  
   
   -- Data
   sp.name = name
   sp.localized = GetSpellInfo(ids[1])
   sp.ids = ids
   sp.roles = roles  

   return sp
end

function addon:getName()
   return self.name
end

function addon:test()
    print("hi")
 end

