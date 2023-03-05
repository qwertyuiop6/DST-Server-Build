return {
    ------------⭐Mod配置信息解释⭐--------
    -----[]之间是mod,{}之间是是否启用,--后面是备注信息
    -----控制一个Mod开关就是改变true或者false
    ---web---
    ["workshop-1714227968"]={enabled=true}, --新版防熊!!
    ["workshop-797304209"]={enabled=true}, --禁止草蜥蜴
    ["workshop-625415718"]={enabled=true},--冰箱保鲜
    ["workshop-375859599"]={enabled=true}, --健康信息
    ["workshop-661253977"]={enabled=false},--死亡不掉落

    ---------⭐⭐ 编辑添加新mod ⭐⭐----------
    --1.删掉一行前面两个横杠--
    --2.在workshop-和"之间填写mod的id--
    --3.最后两个横杠后面备注mod名字--
    --4.检查是否和别的行格式一样,保存

    -- ["workshop-"]={enabled=true}, --
    -- ["workshop-"]={enabled=true}, --
    -- ["workshop-"]={enabled=true}, --
    -- ["workshop-"]={enabled=true}, --
    -- ["workshop-"]={enabled=true}, --
    -- ["workshop-"]={enabled=true}, --
    -- ["workshop-"]={enabled=true}, --


----------⭐⭐复杂选项Mod的配置⭐⭐----------
["workshop-462434129"]={
    enabled=true,
    configuration_options = {
        MOD_RESTART_RESURRECT_HEALTH = 100,
        MOD_RESTART_MAP_SAVE = 1,
        MOD_RESTART_CD_KILL = 2,
        MOD_RESTART_CD_RESURRECT = 3
    }
},--重新开始
["workshop-1301033176"]={enabled=true,
configuration_options = {
    LANG = "simplified"
}
},--中文
["workshop-666155465"] = {
    enabled = true,
    configuration_options = {
        lang = "chs"
    }
},--show me
["workshop-378160973"] = {
    enabled = true,
    configuration_options = {
        ENABLEPINGS = true,
        SHAREMINIMAPPROGRESS = false
    }
}--Global Positions
}