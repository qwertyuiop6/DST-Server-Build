--overrides配置选项的参考
return {
    overrides = {
        -- defalut(默认) 可改为 "never", "rare", "default", "often", "always"
        
        -- MISC
        task_set = "default",           -- "classic", "default", "cave_default"
        start_location = "default",     -- "caves", "default", "plus", "darkness"
        world_size = "medium",         -- "small", "medium", "default", "huge"
        branching = "default",          -- "never", "least", "default", "most"
        loop = "default",               -- "never", "default", "always"
        autumn = "default",             -- "noseason", "veryshortseason", "shortseason", "default", "longseason", "verylongseason", "random"
        winter = "default",             -- "noseason", "veryshortseason", "shortseason", "default", "longseason", "verylongseason", "random"
        spring = "default",             -- "noseason", "veryshortseason", "shortseason", "default", "longseason", "verylongseason", "random"
        summer = "default",             -- "noseason", "veryshortseason", "shortseason", "default", "longseason", "verylongseason", "random"
        season_start = "default",       -- "default", "winter", "spring", "summer", "autumnorspring", "winterorsummer", "random"
        day = "default",                -- "default", "longday", "longdusk", "longnight", "noday", "nodusk", "nonight", "onlyday", "onlydusk", "onlynight"
        weather = "default",
        earthquakes = "default",
        lightning = "default",
        frograin = "never",
        wildfires = "default",
        touchstone = "default",
        regrowth = "veryslow",           -- "veryslow", "slow", "default", "fast", "veryfast"
        cavelight = "default",          -- "veryslow", "slow", "default", "fast", "veryfast"
        boons = "default",
        prefabswaps_start = "default",  -- "classic", "default", "highly random"
        prefabswaps = "default",        -- "none", "few", "default", "many", "max"
        disease_delay="none",
        specialevent = "winters_feast", -- "winters_feast","year_of_the_varg"

        -- RESOURCES
        flowers = "default",
        grass = "default",
        sapling = "default",
        marshbush = "default",
        tumbleweed = "default",
        reeds = "default",
        trees = "default",
        flint = "default",
        rock = "default",
        rock_ice = "default",
        meteorspawner = "default",
        meteorshowers = "default",
        mushtree = "default",
        fern = "default",
        flower_cave = "default",
        wormlights = "default",

        -- UNPREPARED
        berrybush = "default",
        carrot = "default",
        mushroom = "default",
        cactus = "default",
        banana = "default",
        lichen = "default",

        -- ANIMALS
        rabbits = "default",
        moles = "default",
        butterfly = "default",
        birds = "default",
        buzzard = "default",
        catcoon = "default",
        perd = "default",
        pigs = "default",
        lightninggoat = "default",
        beefalo = "default",
        beefaloheat = "default",
        hunt = "often",
        alternatehunt = "default",
        penguins = "default",
        cave_ponds = "default",
        ponds = "default",
        bees = "default",
        angrybees = "default",
        tallbirds = "default",
        slurper = "default",
        bunnymen = "default",
        slurtles = "default",
        rocky = "default",
        monkey = "default",

        -- MONSTERS
        spiders = "default",
        cave_spiders = "default",
        hounds = "default",
        houndmound = "default",
        merm = "default",
        tentacles = "default",
        chess = "default",
        lureplants = "default",
        walrus = "default",
        liefs = "default",
        deciduousmonster = "default",
        krampus = "often",
        bearger = "default",
        deerclops = "default",
        goosemoose = "default",
        dragonfly = "default",
        bats = "default",
        fissure = "default",
        worms = "default",
        wormattacks="rare"
    },
}
