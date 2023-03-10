local L = LibStub("AceLocale-3.0"):NewLocale("GlowFoSho", "enUS", true, false)

-- commands
L["/gfs"] = true
L["standby"] = true
L["Enable/disable the addon"] = true
L["Active"] = true
L["Suspended"] = true

-- dewdrop menu
L["Show Weapon Link"] = "Weapon Link"
L["Displays the link of the enchanted weapon in the chat frame."] = true
L["Show Enchant Link"] = "Enchant Link"
L["Displays the link of the enchant currently on the weapon in the chat frame."] = true		-- changed to not warn about disconnects
L["Show Classic Enchants"] = "Classic Enchants"
L["Allows you to preview Classic enchants."] = true
L["Show BC Enchants"] = "BC Enchants"
L["Allows you to preview BC enchants."] = true
L["Show WotLK Enchants"] = "WotLK Enchants"
L["Allows you to preview WotLK enchants."] = true
L["Show Cata Enchants"] = "Cata Enchants"
L["Allows you to preview Cata enchants."] = true
L["Show Mop Enchants"] = "MoP Enchants"
L["Allows you to preview Mop enchants."] = "Allows you to preview MoP enchants."
L["Show WoD Enchants"] = "WoD Enchants"
L["Allows you to preview WoD enchants."] = true
L["Show DK Runes"] = "Class Enchants"
L["Allows you to preview Runes which are created by DKs."] = "Allows you to preview Class enchants."
L["Show Illusions"] = "Illusions"
L["Allows you to preview Enchanter's Illusions."] = true
L["Enchants"] = true
L["List of weapon enchants you can preview."] = true
L["Clear"] = true
L["Removes enchant from the weapon in the dressing room."] = true

-- messages
L["There is no enchant on the weapon or enchant unknown."] = true

-- whisper enchant
L["!glow"] = true		-- string to request enchant
L["glow>"] = true		-- reply string
L["Unknown enchant."] = true		-- enchant name was not found in the database
L["No weapon enchant link specified."] = true		-- enchant link was not found in the query
L["No weapon link specified."] = true			-- weapon link was not found in the query
L["Syntax: !glow <weapon link> <enchant link>"] = true	-- syntax message displayed when querried with !glow only

-- enchants as they appear in the list
L["Agility (2H)"] = true
L["Agility"] = true
L["Battlemaster"] = true
L["Crusader"] = true
L["Deathfrost"] = true
L["Demonslaying"] = true
L["Executioner"] = true
L["Fiery Weapon"] = true
L["Greater Agility"] = true
L["Greater Impact (2H)"] = true
L["Greater Striking"] = true
L["Healing Power"] = true
L["Icy Chill"] = true
L["Impact (2H)"] = true
L["Lesser Beastslayer"] = true
L["Lesser Elemental Slayer"] = true
L["Lesser Impact (2H)"] = true
L["Lesser Intellect (2H)"] = true
L["Lesser Spirit (2H)"] = true
L["Lesser Striking"] = true
L["Lifestealing"] = true
L["Major Agility (2H)"] = true
L["Major Healing"] = true
L["Major Intellect (2H)"] = true
L["Major Intellect"] = true
L["Major Spellpower"] = true
L["Major Spirit (2H)"] = true
L["Major Striking"] = true
L["Mighty Intellect"] = true
L["Mighty Spirit"] = true
L["Minor Beastslayer"] = true
L["Minor Impact (2H)"] = true
L["Minor Striking"] = true
L["Mongoose"] = true
L["Potency"] = true
L["Savagery (2H)"] = true
L["Soulfrost"] = true
L["Spell Power"] = true
L["Spellsurge"] = true
L["Strength"] = true
L["Striking"] = true
L["Sunfire"] = true
L["Superior Impact (2H)"] = true
L["Superior Striking"] = true
L["Unholy Weapon"] = true
L["Winter's Might"] = true
L["Greater Potency"] = true
L["Greater Savagery (2H)"] = true
L["Exceptional Spellpower"] = true
L["Exceptional Agility"] = true
L["Exceptional Spirit"] = true
L["Icebreaker"] = true
L["Massacre (2H)"] = true
L["Scourgebane (2H)"] = true
L["Giant Slayer"] = true
L["Mighty Spellpower"] = true
L["Superior Potency"] = true
L["Accuracy"] = true
L["Berserking"] = true
L["Black Magic"] = true
L["Lifeward"] = true
L["Titanium Weapon Chain"] = true
L["Blood Draining"] = true
L["Blade Ward"] = true
L["Spellpower (2H)"] = "Spellpower (Staff)"
L["Greater Spellpower (2H)"] = "Greater Spellpower (Staff)"
L["Mighty Agility (2H)"] = true
L["Avalanche"] = true
L["Elemental Slayer"] = true
L["Heartsong"] = true
L["Hurricane"] = true
L["Landslide"] = true
L["Mending"] = true
L["Power Torrent"] = true
L["Windwalk"] = true
L["Rune of Cinderglacier"] = true
L["Rune of Razorice"] = true
L["Rune of Spellbreaking"] = true
L["Rune of Spellshattering (2H)"] = true
L["Rune of Lichbane"] = true
L["Rune of Swordbreaking"] = true
L["Rune of Swordshattering (2H)"] = true
L["Rune of the Fallen Crusader"] = true
L["Rune of the Nerubian Carapace"] = true
L["Rune of the Stoneskin Gargoyle (2H)"] = true
L["Pyrium Weapon Chain"] = true
L["Elemental Force"] = true
L["Windsong"] = true
L["Colossus"] = true
L["Dancing Steel"] = true
L["Jade Spirit"] = true
L["River's Song"] = true
L["Living Steel Weapon Chain"] = true
L["Glorious Tyranny"] = true

L["Mark of Blackrock"] = true
L["Mark of Shadowmoon"] = true
L["Mark of the Frostwolf"] = true
L["Mark of the Shattered Hand"] = true
L["Mark of the Thunderlord"] = true
L["Mark of Warsong"] = true
L["Mark of Bleeding Hollow"] = true
L["Glory of the Thunderlord"] = true
L["Glory of the Shadowmoon"] = true
L["Glory of the Blackrock"] = true
L["Glory of the Warsong"] = true
L["Glory of the Frostwolf"] = true
L["Illusion: Poisoned"] = true
L["Illusion: Windfury"] = true
L["Illusion: Frostbrand"] = true
L["Illusion: Flametongue"] = true
L["Illusion: Earthliving"] = true
L["Illusion: Rockbiter"] = true
L["Illusion: Greater Spellpower"] = true
L["Illusion: Mongoose"] = true
L["Illusion: Executioner"] = true
L["Illusion: Berserking"] = true
L["Illusion: Blood Draining"] = true
L["Illusion: Battlemaster"] = true
L["Illusion: Power Torrent"] = true
L["Illusion: Agility"] = true
L["Illusion: Hidden"] = true
L["Illusion: Glorious Tyranny"] = true
L["Illusion: Fiery Weapon"] = true
L["Illusion: Lifestealing"] = true
L["Illusion: Crusader"] = true
L["Illusion: Elemental Force"] = true
L["Illusion: River's Song"] = true
L["Illusion: Spellsurge"] = true
L["Illusion: Landslide"] = true
L["Illusion: Mending"] = true
L["Illusion: Unholy"] = true
L["Illusion: Striking"] = true
L["Illusion: Primal Victory"] = true
L["Illusion: Jade Spirit"] = true
L["Illusion: Flames of Ragnaros"] = true
L["Illusion: Winter's Grasp"] = true