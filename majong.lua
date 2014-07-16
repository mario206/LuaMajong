-- 十位：
-- 1:万    2:筒     3:条     4:字      5:花

-- 个位：
-- 1-9:1-9
-- 1-7:东 南 西 北 红中 白板 发财
-- 1-8:梅 兰 竹 菊 春 夏 秋 冬

-- 例如
-- 八筒：28

-- 函数列表:
-- public:
--          is_good_pai(pai)             判断同一花色的牌是否能胡,返回true or false
--          get_disarranged_majong()     返回随机打乱的136张麻将
--          get_four_group_pai(majong)   根据传入的136张麻将，返回4组牌，每组14张
--          sort_pai_by_type(pai)        根据传入的14张牌，分成5种花色的牌返回
--          print_pai_in_word(pai)       打印传入的牌

-- private: _is_good_pai(pai)            判断同一花色的牌是否能胡,返回true or false

NUM = {
{"一","二","三","四","五","六","七","八","九"},
{"一","二","三","四","五","六","七","八","九"},
{"一","二","三","四","五","六","七","八","九"},
{"东","南","西","北","中","白","发"}
}
TYPE= {"万","筒","条",""}





-- 返回打乱的136张麻将
function get_disarranged_majong()
    local majong = {
            11,11,11,11,12,12,12,12,13,13,13,13,
            14,14,14,14,15,15,15,15,16,16,16,16,
            17,17,17,17,18,18,18,18,19,19,19,19,
            21,21,21,21,22,22,22,22,23,23,23,23,
            24,24,24,24,25,25,25,25,26,26,26,26,
            27,27,27,27,28,28,28,28,29,29,29,29,
            31,31,31,31,32,32,32,32,33,33,33,33,
            32,32,32,32,35,35,35,35,36,36,36,36,
            37,37,37,37,38,38,38,38,39,39,39,39,
            41,41,41,41,42,42,42,42,43,43,43,43,
            44,44,44,44,45,45,45,45,46,46,46,46,
            47,47,47,47
}

math.randomseed(tostring(os.time()):reverse():sub(1, 6));
for  n = 0,20,1 do
    for i = 1,136,1 do
        local x = math.random(1,136)
        local t = majong[i]
        majong[i] = majong[x]
        majong[x] = t
    end
    return majong
end
end


-- 根据传入的牌返回四组牌
function get_fourgroup_pai(majong)
    --每组返回14张牌，方便检测
    local Pai1 = { }
    local Pai2 = { }
    local Pai3 = { }
    local Pai4 = { }

    -- 分四组牌
    for i = 1,14,1 do
        Pai1[#Pai1 + 1] = majong[i]
    end
    for i = 15,28,1 do
        Pai2[#Pai2 + 1] = majong[i]
    end
    for i = 29,42,1 do
        Pai3[#Pai3 + 1] = majong[i]
    end
    for i = 43,56,1 do
        Pai4[#Pai4 + 1] = majong[i]
    end
    -- 排下序，总算不用自己写排序了
    table.sort(Pai1)
    table.sort(Pai2)
    table.sort(Pai3)
    table.sort(Pai4)

    return Pai1,Pai2,Pai3,Pai4
end

function print_pai_in_word(pai)

    for i = 1,#pai do
        local m_num = pai[i] % 10;
        pai[i] = pai[i] / 10;
        local m_type = math.floor(pai[i] % 10);
        io.write(NUM[m_type][m_num],TYPE[m_type]',')
    end
    io.write('\n')
end



-- 打乱检测


local majong = get_disarranged_majong()
local paiA = {}
local paiB = {}
local paiC = {}
local paiD = {}
paiA,paiB,paiC,paiD = get_fourgroup_pai(majong)
print_pai_in_word(paiA)
print_pai_in_word(paiB)
print_pai_in_word(paiC)
print_pai_in_word(paiD)

-- for i = 1,#paiA do
--     io.write(paiA[i],',')
-- end
-- io.write('\n')
-- for i = 1,#paiB do
--     io.write(paiB[i],',')
-- end
-- io.write('\n')
-- for i = 1,#paiC do
--     io.write(paiC[i],',')
-- end
-- io.write('\n')
-- for i = 1,#paiD do
--     io.write(paiD[i],',')
-- end
-- io.write('\n')

