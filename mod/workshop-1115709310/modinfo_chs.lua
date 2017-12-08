description =
[[新增一个交易系统，可以在游戏内赚钱用钱了。
使用专属道具来赚取金币。
点击左上角的图标打开商品交易面板，使用金币换取需要的东西。
珍贵品每3天的早上会刷新。
不同的季节商品的价格不一样。
]]

configuration_options =
{
    {
        name = "Language",
        label = "语言",
        options =   {
                        {description = "English", data = false},
                        {description = "简体中文", data = true},
                    },
        default = true,
    },
    {
        name = "Disintegrate",
        label = "允许点金分解",
        options =   {
                        {description = "否", data = false, hover = "不允许使用点金杖分解任何掉落物".."\n".."点金杖仅可用来击杀低血量怪物以换取金币".."\n".."选此选项后以点金杖攻击低血量生物可100%几率击杀"},
                        {description = "是", data = true, hover = "允许使用点金杖分解任何掉落物".."\n".."选此选项后以点金杖攻击低血量生物仅可25%几率击杀"},
                    },
        default = true,
    },
}