
--返回打乱的136张麻将
function get()
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


-- 打乱检测
local majong = get()
local paiA = {}
local paiB = {}
local paiC = {}
local paiD = {}
paiA,paiB,paiC,paiD = get_fourgroup_pai(majong)
for i = 1,#paiA do
    io.write(paiA[i],',')
end
io.write('\n')
for i = 1,#paiB do
    io.write(paiB[i],',')
end
io.write('\n')
for i = 1,#paiC do
    io.write(paiC[i],',')
end
io.write('\n')
for i = 1,#paiD do
    io.write(paiD[i],',')
end
io.write('\n')

