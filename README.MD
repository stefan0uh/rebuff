# Rebuff
Check for missing buffs or consumables and broadcast them to your group.

https://www.curseforge.com/wow/addons/rebuff

### Options:
* Select broadcast channel (RAID, PARTY, SAY)
* Broadcast options for Buffs and Consumables or World Buffs
* Readycheck dialog for broadcast (OPT-IN)
* Direct broadcast on readycheck (OPT-IN)
* Custom message when full buffed

---

### Separate selection for Tanking, Physical and Caster
* **Tanking**: Druid, Warrior (set as MAINTANK in raid)
* **Physical**: Druid, Hunter, Rogue, Warrior and Shaman (No caster buffs, like Intellect or Spirit)
* **Caster**: Druid, Mage, Priest, Shaman/Paladin and Warlock

> Currently there a some false/positives, cause of an bad role check.
> Like Healer-classes are not casters, but currently its not possible to seperate, same as Hunters.
  
---
### Buffs
Its doesnt matter if a Group or Single buff is applied.

* Arcane Brilliance, Arcane Intellect
* Dampen Magic (Rank 5)
* Gift of the Wild, Mark of the Wild
* Thorns (Rank 6)
* Prayer of Fortitude, Power Word: Fortitude
* Prayer of Shadow, Protection Shadow Protection
* Prayer of Spirit, Divine Spirit

###### Alliance Bonus
* Greater Blessing of Kings, Blessing of Kings
* Greater Blessing of Might, Blessing of Might
* Greater Blessing of Salvation, Blessing of Salvation
* Greater Blessing of Wisdom, Blessing of Wisdom
* Greater Blessing of Sanctuary, Blessing of Sanctuary

### Consumable check for Flasks, Elixirs, Magic Protection Potion and Food
At the current state, it checks only one buff.
> (Example: Elixirs is selected, so the person doesn't need all elixirs just one.)


#### Blasted Lands
* Cerebral Cortex Compound
* Gizzard Gum
* Lung Juice Cocktail

#### Zul'Gurub Zanzas (1 of 3, UNIQUE)
* Spirit of Zanza
* Sheen of Zanza
* Swiftness of Zanza

#### Rumsey/Gordoc
* Rumsey Rum Black Label
* Rumsey Rum Dark
* Gordok Green Grog
* Kreeg's Stout Beatdown

#### JuJu
###### Restistance
* Juju Chill
* Juju Ember
###### Physical
* Juju Might
* Juju Power

#### Magic Protection Potion
* Greater Fire Protection Potion
* Greater Arcane Protection Potion
* Greater Frost Protection Potion
* Greater Nature Protection Potion
* Greater Shadow Protection Potion

#### Flask (1 of 4, UNIQUE)
* Flask of the Titans
* Flask of Distilled Wisdom
* Flask of Supreme Power
* Flask of Chromatic Resistance

#### Elixirs
###### Defense
* Elixir of Superior Defense
* Gift of Arthas
* Elixir of the Giants
* Elixir of Fortitude
* Elixir of Superior Defense
* Major Troll's Blood Potion

###### Physical
* Elixir of the Mongoose
* Winterfall Firewater
* Elixir of Giants

###### Caster
* Elixir of Greater Firepower
* Elixir of Firepower
* Elixir of Shadow Power
* Elixir of Frost Power
* Greater Arcane Elixir
* Arcane Elixir
* Mageblood Potion

---

### Worldbuff check
* Warchief's Blessing (Horde only)
* Rallying Cry of the Dragonslayer (ONY/NEF head)
* Spirit of Zandalar (HAKAR Hearth)
* Songflower Serenade
* Mol'dar's Moxie (DM)
* Fengus' Ferocity (DM)
* Slip'kik's Savvy (DM)
* Darkmoon Faire Fortune Buffs (1 of 8, UNIQUE)

---

### Chat commands:
To trigger the addon use `/rebuff` or `/rb`.

##### Command
`/rebuff print` (Broadcast a report)

---

#### ERRORs?
`/console scriptErrors 1`

If you found an error or want to improve the addon, please make a new issue or Pull-Request at [Github](https://github.com/stefan0uh/rebuff)!

--- 

**Author:** Toolate (The Dominion) - Horde - Nethergarde-Keep EU

