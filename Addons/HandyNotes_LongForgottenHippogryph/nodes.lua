local myname, ns = ...

ns.SetupMapOverlay = nil

ns.hiddenConfig = {
    groupsHidden = true,
}

ns.defaultsOverride = {
    show_on_minimap = true,
}

local EPHEMERAL = {
    label="Ephemeral Crystal",
    note="|cFFFFFF00Use five of these before anyone else, without leaving the zone or dying, and you'll get the {item:138258:Reins of the Long-Forgotten Hippogryph}|r",
    texture=ns.atlas_texture("islands-azeritechest", {r=1, g=0, b=0.5}),
    group="Long Forgotten Hippogryph",
}

ns.RegisterPoints(630, {
    -- PurgatoryWolf's comment on wowhead:
    -- https://www.wowhead.com/item=138258/reins-of-the-long-forgotten-hippogryph#comments:id=2453258
    [29902655] = {note="On island"},
    [30302395] = {note="In the cave"},
    [29853587] = {note="Between some dead trees"},
    [34911715] = {note="Behind the ruins"},
    [34803530] = {note="On cliff edge"},
    [34603570] = {note="In cave at the base of the hill"},
    [35002200] = {note="Near the water"},
    [35722507] = {note="Beside the tree with the lantern and fence, to the left of the path"},
    [36601220] = {note="In the open"},
    [36002300] = {note="Between two trees on the road"},
    [35603780] = {note="By a tree"},
    [36003600] = {note="On cliff edge"},
    [37002175] = {note="By a tree"},
    [37503290] = {note="Behind a wall next to a bush and tree"},
    [38690931] = {note="On grass next to bush"},
    [40303280] = {note="Next to tree"},
    [40553760] = {note="In the middle of the road, by a tree"},
    [40723590] = {note="Next to tree"},
    [41403100] = {note="In Llothien Grizzly Cave, to the right"},
    [41503100] = {note="In the cave"},
    [42200850] = {note="On the hillside"},
    [42661806] = {note="Inside Runa’s Hovel Cave, on rock between spine and skull"},
    [42206230] = {note="On the hill near the Cove Skrog"},
    [43002800] = {note="Behind tree, next to Doomlord Kazrok"},
    [44105980] = {note="On the small hill next to the ship"},
    [45501720] = {note="Next to the lake, where the river begins"},
    [45424542] = {note="Next to a tree"},
    [45005360] = {note="On the coast, in the broken half of a ship"},
    [46550536] = {},
    [46560853] = {note="Next to a tree"},
    [46901775] = {note="At the top of the slope"},
    [46904900] = {note="On hill, above the neutral giants, behind a tree"},
    [46585360] = {note="Between some rocks, by the sleeping bears"},
    [47102580] = {note="Next to the blue crystal lake"},
    [47203300] = {note="Next to the river"},
    [47306190] = {note="Between two rocks"},
    [48884561] = {note="On a rock"},
    [48004800] = {note="Next to the two neutral giants at the bottom of the valley"},
    [48055270] = {note="In the cave next to some piles of gold"},
    [48575728] = {note="In Oceanus Cove, inside a shipwreck"},
    [49000800] = {note="On a little rock in Lair of the Deposed"},
    [49402400] = {note="In bushes, behind the shrine"},
    [49392770] = {note="Next to a tree"},
    [49303150] = {note="Behind a bush"},
    [49305055] = {note="Behind the sleeping giant"},
    [49185354] = {note="On a cliff above the bridge"},
    [49675535] = {note="In Oceanus Cove, next to piles of gold"},
    [49285803] = {note="By the broken pillar right next to the bride and groom"},
    [50501640] = {note="Between three trees"},
    [50502030] = {note="Inside Layhallow cave @ 47.9, 24.8"},
    [50003310] = {note="Next to shells and hut"},
    [50734989] = {note="In the cave at Shipwreck Arena"},
    [50485699] = {note="In the cave, close to eternal bride and groom"},
    [51403760] = {note="Underwater, near to Mrrgrl"},
    [51006500] = {note="Next to the rope tied around the poles"},
    [51007500] = {note="In a cave by the roots"},
    [51805760] = {note="In Oceanus Cove, next to broken ship"},
    [52401340] = {note="Next to a tree"},
    [52292510] = {note="Off road, next to a tree"},
    [52153185] = {note="By the shrine"},
    [52963594] = {note="Underwater next to Narthalas Academy"},
    [52705790] = {note="Up on the hill"},
    [52007100] = {note="On a rock by the water"},
    [53362608] = {note="Between the three trees"},
    [53702805] = {note="In a cave by the river"},
    [53083603] = {},
    [53616336] = {note="By the torch in the alcove"},
    [54332603] = {note="Next to tree roots"},
    [54102760] = {note="Behind the hut, in the bushes"},
    [54802800] = {note="Behind the tree"},
    [54503350] = {note="In the lake, next to basilisks"},
    [54855225] = {note="In the cave with Cole"},
    [55551030] = {note="Up the side of the cliff"},
    [55902940] = {note="Inside the three pillars"},
    [55563272] = {note="Bottom of the cliff, by a tree"},
    [55005500] = {note="Bottom of hill"},
    [55984282] = {},
    [56001200] = {note="By the pink flower"},
    [56903884] = {note="At the shore"},
    [56922600] = {note="In the cave, entrance @ 55.74, 25.46"},
    [56004000] = {note="Under the bridge"},
    [57401679] = {},
    [57502660] = {note="By the road"},
    [57003100] = {note="In the middle of a circle"},
    [57694231] = {note="In cave with a big giant"},
    [58222465] = {note="At the top of the cliff"},
    [58814502] = {note="In cave with Commander Eksis, on rock between spine and skull"},
    [59752784] = {note="Behind a tree"},
    [59703770] = {},
    [59063748] = {note="Near the statue"},
    [59303830] = {note="Behind a naga tent"},
    [60001700] = {note="By a tree"},
    [60103500] = {note="Next to a broken pillar"},
    [60205460] = {note="Near shadowfiends under a small tent"},
    [60404670] = {},
    [60004900] = {},
    [60105320] = {},
    [61103040] = {note="In a cave, on the rock to the right"},
    [61903090] = {note="Behind a tree"},
    [61604010] = {},
    [62253590] = {note="By trees"},
    [62304050] = {note="By a naga tent"},
    [62655246] = {note="By a tree"},
    [62205470] = {note="By a tree"},
    [63384614] = {note="Under a tree"},
    [63485400] = {note="In Gloombound Barrow, @ 63.48, 54.00"},
    [64003400] = {note="Near the table in The Empyrean Society Enclave"},
    [64003900] = {},
    [65402950] = {note="Inside big tree stump"},
    [65403840] = {},
    [65504240] = {note="By the shore"},
    [65155082] = {note="Under a tree"},
    [67703280] = {},
    [67003370] = {note="By pillars"},
    [67004600] = {note="By a log"},
    [67105200] = {note="Outside entrance to the Ruined Sanctum"},
    [68202430] = {},
}, EPHEMERAL)

ns.RegisterPoints(632, { -- Oceanus Cove
    [45833076] = {note="Next to piles of gold"},
    [50897734] = {note="Inside the shipwreck"},
    [81138155] = {note="By the shipwreck"},
}, EPHEMERAL)