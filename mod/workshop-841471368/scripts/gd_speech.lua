local language = GetModConfigData("language")
--默认
local gd_strings = {
    permission_give = function(opts) return string.format("我已经把权限给了（%s）！", opts[1]) end,
    permission_give_me = function(opts) return string.format("可惜，不能给自己权限！") end,
    permission_give_num_err = function(opts) return string.format("没有玩家是这个数字，请重新给权限吧！") end,
    permission_remove = function(opts) return string.format("已经收回了给（%s）的权限！", opts[1]) end,
    permission_remove_no = function(opts) return string.format("（%s）没有我的权限，不能收回哦！", opts[1]) end,
    permission_remove_me = function(opts) return string.format("不能收回自己的权限哦！") end,
    permission_remove_num_err = function(opts) return string.format("没有玩家是这个数字，请重新收回权限吧！") end,
    permission_get = function(opts) return string.format("我获得了（%s）的权限！", opts[1]) end,
    permission_lose = function(opts) return string.format("（%s）给的权限已被收回！", opts[1]) end,
    permission_del_tip = function(opts) return string.format("按U输入#del 玩家数字，我还可以回收权限哦！") end,
    permission_no = function(opts) return string.format("这是（%s）的东西，我需要权限！", opts[1]) end,
    item_use = function(opts) return string.format("（%s）要使用我的%s！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    item_dig = function(opts) return string.format("（%s）要挖我的%s！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    item_dig_cant = function(opts) return string.format("这是（%s）的东西，我不能挖！", opts[1]) end,
    item_smash = function(opts) return string.format("（%s）要砸我的%s！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    item_smash_cant = function(opts) return string.format("这是(%s)的%s，我需要权限才能砸！", opts[1], opts[2]) end,
    item_light = function(opts) return string.format("（%s）要烧我的%s！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    item_light_cant = function(opts) return string.format("这是（%s）的东西，我不能烧！", opts[1]) end,
    item_haunt = function(opts) return string.format("幽灵(%s)要作祟我的%s！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    item_open = function(opts) return string.format("（%s）要打开我的%s！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    item_pick = function(opts) return string.format("（%s）要采我的%s！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    item_pick_cant = function(opts) return string.format("这%s是（%s）的，我不能采！", opts[2], opts[1]) end,
    item_get = function(opts) return string.format("（%s）要拿我的%s！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    item_get_cant = function(opts) return string.format("这%s是（%s）的，我不能拿！", opts[2], opts[1]) end,
    item_chop = function(opts) return string.format("（%s）要砍我的%s！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    item_chop_cant = function(opts) return string.format("这%s是（%s）的，我不能砍！", opts[2], opts[1]) end,
    item_spell = function(opts) return string.format("（%s）要对我的%s施法！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    buildings_dig_cant = function(opts) return string.format("离别人建筑群太近了，我需要权限才能挖！") end,
    buildings_pick_cant = function(opts) return string.format("这是别人家的东西，我需要权限才能采！") end,
    buildings_light_cant = function(opts) return string.format("这是别人家的东西，我需要权限才能烧！") end,
    buildings_get_cant = function(opts) return string.format("这是别人家的东西，我需要权限才能拿！") end,
    buildings_chop_cant = function(opts) return string.format("这是别人家的树，我需要权限才能砍！") end,
    buildings_net_cant = function(opts) return string.format("这是别人家的%s，我需要权限才能抓！", opts[2]) end,
    buildings_spell_cant = function(opts) return string.format("在别人家我需要权限才能施法！") end,
    beefalo_saddle = function(opts) return string.format("（%s）要给我的%s上鞍！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    beefalo_saddle_cant = function(opts) return string.format("这是（%s）的%s，我不能上鞍！", opts[1], opts[2]) end,
    beefalo_unsaddle = function(opts) return string.format("（%s）要给我的%s下鞍！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    beefalo_unsaddle_cant = function(opts) return string.format("这是（%s）的%s，我不能下鞍！", opts[1], opts[2]) end,
    beefalo_ride = function(opts) return string.format("（%s）要骑我的%s！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end,
    beefalo_ride_cant = function(opts) return string.format("这是（%s）的%s，我不能骑！", opts[1], opts[2]) end,
    tree_open_cant = function(opts) return string.format("这是%s的树，我需要权限才能打开！", opts[1] ~= nil and "（"..opts[1].."）" or "别人家") end,
    trees_dig_cant = function(opts) return string.format("这是%s的树林，我不能挖！", opts[1] ~= nil and "（"..opts[1].."）" or "别人家") end,
    trees_chop_cant = function(opts) return string.format("这是%s的树林，我不能砍！", opts[1] ~= nil and "（"..opts[1].."）" or "别人家") end,
    player_start = function(opts) return string.format("啊，得到好多东西，真是愉快的一天！") end,
    player_leaved = function(opts) return string.format("东西的主人%s已经离开了这个世界！" , opts[1] ~= nil and "（"..opts[1].."）" or "") end,
    command_error = function(opts) return string.format("命令输入错误，请重新输入吧！") end,
    command_help = function(opts) return string.format("命令格式：\n给权限命令：#add  数字\n收权限命令：#del  数字\n按Tab键在玩家列表左边可以查看对应的玩家数字\n建议有玩家进出时不要收给权限") end,

    noadmin_hammer_cant = function(opts) return string.format("我没有权限拆除%s！", opts[1]) end,
    item_master_to = function(opts) return string.format("所有者: %s" , opts[1]) end,
    item_server_to = function(opts) return string.format("%s通往『%s』" , opts[1] ~= nil and "从『"..opts[1].."』" or "", opts[2]) end,
    clean_warning = function(opts) return string.format("%s%s秒后进行清理" , opts[1] ~= nil and "『"..opts[1].."』将在" or "", opts[2]) end,
    cleaning = function(opts) return string.format("%s正在清理中..." , opts[1] ~= nil and "『"..opts[1].."』" or "") end,
}

--欢乐版
if language == "redpig_fun" then
    gd_strings.permission_give = function(opts) return string.format("我把糖糖给了（%s），宝宝要乖哦！", opts[1]) end
    gd_strings.permission_give_me = function(opts) return string.format("哦吼，我好自恋啊！") end
    gd_strings.permission_give_num_err = function(opts) return string.format("我要找的人貌似在外星球吧！") end
    gd_strings.permission_remove = function(opts) return string.format("这宝宝不乖，我已经收回了给（%s）的糖糖！", opts[1]) end
    gd_strings.permission_remove_no = function(opts) return string.format("（%s）的口袋里没有本宝宝的糖糖，不能没收喔！", opts[1]) end
    gd_strings.permission_remove_me = function(opts) return string.format("我是大撒币！") end
    gd_strings.permission_remove_num_err = gd_strings.permission_give_num_err
    gd_strings.permission_get = function(opts) return string.format("宝宝好开心，我获得了（%s）的糖糖！", opts[1]) end
    gd_strings.permission_lose = function(opts) return string.format("宝宝心里委屈，（%s）给的糖糖被没收了！", opts[1]) end
    gd_strings.permission_del_tip = function(opts) return string.format("宝宝不乖的话，按U输入#del 玩家数字，我还可以回收糖糖哦！") end
    gd_strings.permission_no = function(opts) return string.format("宝宝不开心，这是（%s）的东西，我需要权限！", opts[1]) end
    gd_strings.item_smash = function(opts) return string.format("（%s）这撒币要砸我的%s！\n按U输入#add %s 可以给权限", opts[1], opts[2], opts[3]) end
    gd_strings.item_smash_cant = function(opts) return string.format("宝宝需要权限才能砸(%s)的%s！", opts[1], opts[2]) end
    gd_strings.item_light = function(opts) return string.format("（%s）这小子要烧我的%s！\n按U输入#add %s 可以给权限，想的美", opts[1], opts[2], opts[3]) end
    gd_strings.item_light_cant = function(opts) return string.format("宝宝烧不了（%s）的东西！", opts[1]) end
    gd_strings.item_haunt = function(opts) return string.format("幽灵(%s)这小样要作祟我的%s！\n按U输入#add %s 可以给权限，呵呵", opts[1], opts[2], opts[3]) end
    gd_strings.item_pick_cant = function(opts) return string.format("宝宝需要权限才能采（%s）的%s！", opts[1], opts[2]) end
    gd_strings.item_get_cant = function(opts) return string.format("宝宝需要权限才能拿（%s）的%s！", opts[1], opts[2]) end
    gd_strings.item_chop_cant = function(opts) return string.format("宝宝需要权限才能砍（%s）的%s！", opts[1], opts[2]) end
    gd_strings.buildings_dig_cant = function(opts) return string.format("干，离别人建筑群太近了，不能挖！") end
    gd_strings.buildings_pick_cant = function(opts) return string.format("宝宝好难过，这是别人家的东西，我采不了！") end
    gd_strings.buildings_light_cant = function(opts) return string.format("干，这是别人家的东西，我不能烧！") end
    gd_strings.buildings_get_cant = function(opts) return string.format("干，这东西长在别人家，我不能拿！") end
    gd_strings.buildings_chop_cant = function(opts) return string.format("干，这是别人家的树，我不能砍！") end
    gd_strings.buildings_spell_cant = function(opts) return string.format("宝宝是乖孩纸，不可以在别人家做这么做！") end
    gd_strings.beefalo_saddle_cant = function(opts) return string.format("宝宝不能给（%s）的%s上鞍！", opts[1], opts[2]) end
    gd_strings.beefalo_unsaddle_cant = function(opts) return string.format("宝宝不能给（%s）的%s下鞍！", opts[1], opts[2]) end
    gd_strings.beefalo_ride_cant = function(opts) return string.format("宝宝不能骑（%s）的%s！", opts[1], opts[2]) end
    gd_strings.tree_open_cant = function(opts) return string.format("宝宝不开心，宝宝心里委屈，宝宝拿不到礼物！") end
    gd_strings.player_start = function(opts) return string.format("啊，宝宝获得了好多东东，真是愉快的一天！") end
    gd_strings.player_leaved = function(opts) return string.format("哈哈，这东西的主人%s已经狗带了...", opts[1] ~= nil and "（"..opts[1].."）" or "") end
    gd_strings.command_error = function(opts) return string.format("宝宝不开心，宝宝心里委屈，但宝宝不说！") end

    gd_strings.noadmin_hammer_cant = function(opts) return string.format("宝宝拆不了%s，它受到管理大大的保护！", opts[1]) end
end

function GetSayMsg(key, ...)
    local fn = gd_strings[key]
    if fn == nil then return "" end

    return fn({...})
end