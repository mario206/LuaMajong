

local MJ_WAN       = 1      --万
local MJ_TIAO      = 2		--条
local MJ_BING      = 3		--饼
local MJ_FENG      = 4		--东西南北(1357)
local MJ_ZFB	   = 5		--中发白(135)

-- local Pai_MING		=0		--明
-- local Pai_AN		    =1		--暗

local Pai_My		= 0		--手牌组
local Pai_Chi		= 1		--吃牌组
local Pai_Peng		= 2		--碰牌组
local Pai_Gang		= 3		--杠牌组
local Pai_Ting		= 4      --听牌组

-- 牌结构：
--
--     十位     个位
--     1 万   （1-9）
--     2 条   （1-9）
--     3 饼   （1-9）
--     4 风牌 （1-东、3-西、5-南、7-北）		（风箭牌用奇数为了避免组成顺子）
--     5 箭牌 （1-中、3-发、5-白）
--



local function CheckSinglePaiMingAn(pai)
	--检查牌的明暗或者空
	return math.floor(pai%10000/1000)
end

local function CheckSinglePaiGroup(pai)
	--检查单张牌所属牌组
	return math.floor(pai%1000/100)
end

local function CheckSinglePaiType(pai)
	--检查单张牌的类型，万饼筒条
	return math.floor(pai%100/10)
end

local function CheckSinglePaiNum(pai)
	--检查单张牌的数值
	return math.floor(pai%10)
end

local function GetPaiTypeNum(pai)
	--返回标准牌型数值(包括牌型与数字)
	return math.floor(pai%100)
end

local function CheckSinglePaiType(pai)
	--检查单张牌的类型，万饼筒条
	return math.floor(pai%100/10)
end

local function CheckSinglePaiNum(pai)
	--检查单张牌的数值
	return math.floor(pai%10)
end

local function SortByType(userpai)

	-- 将用户的牌分成 万，条，饼，风，中发白四组并排序返回
	local sort_pai = {
						[MJ_WAN] =  {},
						[MJ_TIAO] = {},
						[MJ_BING] = {},
						[MJ_FENG] = {},
						[MJ_ZFB]  = {}
					}
	for i = 1,#userpai,1 do
		type = CheckSinglePaiType(userpai[i])
		table.insert(sort_pai[type],userpai[i])
	end

	for i = 1,5,1 do
		table.sort(sort_pai[i])
	end

	-- --  测试代码 ----
	-- for i = 1,#sort_pai,1 do
	-- 	for j = 1,#sort_pai[i],1 do
	-- 		print (sort_pai[i][j]),
	-- 	end
	-- 	print ('\n')
	-- end
	-- -------------

	return sort_pai
end

local function ValidAA(pai,i,n)
	if i + 1 <= n and pai[i] == pai[i+1]	then
		return true
	else
		return false
	end
end

local function ValidAAA(pai,i,n)
	if i + 2 <= n and pai[i] == pai[i+1] and pai[i] == pai[i+2]	then
		return true
	else
		return false
	end
end




local function ValidAAAA(pai,i,n)
	if i + 3 <= n and pai[i] == pai[i+1] and pai[i] == pai[i+2] and pai[i] == pai[i+3]	then
		return true
	else
		return false
	end
end

local function ValidAA_p(pai,i,n)	-- 针对风牌箭牌的特化版
	if i + 1 <= n and pai[i] == pai[i+1] then
		return true
	else
		return false
	end
end

local function ValidAAA_p(pai,i,n)     -- 针对风牌箭牌的特化版
	if i + 2 <= n and pai[i] == pai[i+1] and pai[i] == pai[i+2] then
		return true
	else
		return false
	end
end

local function ValidAAAA_p(pai,i,n)	-- 针对风牌箭牌的特化版
	if i + 3 <= n and pai[i] == pai[i+1] and pai[i] == pai[i+2] and pai[i] == pai[i+3]	then
		return true
	else
		return false
	end
end
 function ValidABC(pai,i,n)
	-- 顺子要避开 1 222 3  这种可能组成 123 22 的情况
	-- 所以拆成两个列表  (1 2 3)|(22)
	-- 然后判断 ValidHu(22)

	-- 只有两张牌，必定没顺
	if n - i < 2	then
		return false
	end

	local found_B = false
	local found_C = false
	for j = i+1,#pai,1 do
		if found_B == false and pai[j] == ( pai[i] + 1 ) then
			found_B = true
			-- 交换两张牌的位置
			t = pai[i + 1]
			pai[i + 1] = pai[j]
			pai[j] = t
		end
	end

	for k = i + 2,#pai,1 do
		if found_C== false and pai[k] == ( pai[i] + 2 ) then
			found_C = true
			-- 交换两张牌的位置
			t = pai[i + 2]
			pai[i + 2] = pai[k]
			pai[k] = t
		end
	end

	-- for k  = 1,#pai,1 do
	-- 	print (pai[k])
	-- end

	-- 如果能找到顺，判断剩下的牌是否能胡
	if found_B == true and found_C == true then
		-- 创建待判断列表
		local new_list = {}
		local k = 1
		for j = i + 3,#pai,1 do
			new_list[k] = pai[j]
			k = k + 1
		end
		-- 对新建数组进行排序
		table.sort(new_list)
		-- for k = 1,#new_list,1 do
		-- 	print (new_list[k])
		-- end
		return ValidHu(new_list,1,#new_list)
	else
		return false
	end
end


function ValidHu(pai,i,n)
	-- 空牌组直接胡
	if n == 0	then
		return true
	end
	-- 少于两个牌，不可能胡
	if n < 2	then
		return false
	end
	-- 检测到末尾，胡
	if i > n then
		return true
	end

	if ValidAA(pai,i,n) and ValidHu(pai,i+2,n) then
		return true
	elseif ValidAAA(pai,i,n)	and ValidHu(pai,i+3,n) then
		return true
	elseif ValidAAAA(pai,i,n) and ValidHu(pai,i+4,n) then
		return true
	-- elseif ValidABC(pai,i,n) and ValidHu(pai,i+4,n) then
	elseif ValidABC(pai,i,n)	then	-- 顺内部构建新数组调用ValidHu
		return true
	else
		return false
	end
end





local function ValidHu_p(pai,i,n)		-- 针对风牌箭牌的特化版 不用判断顺子
	-- 空牌组直接胡
	if n == 0 then
		return true
	end
	-- 少于两个牌，不可能胡
	if n < 2	then
		return false
	end
	-- 检测到末尾，胡
	if i > n 	then
		return true
	end
	if ValidAA_p(pai,i,n) and ValidHu_p(pai,i+2,n) then
		return true
	elseif ValidAAA_p(pai,i,n) and ValidHu_p(pai,i+3,n) then
		return true
	elseif ValidAAAA_p(pai,i,n)	and ValidHu_p(pai,i+4,n) then
		return true
	end
	return false
end


local function CheckHu(userpai)

	local pai = {
						[MJ_WAN] =  {},
						[MJ_TIAO] = {},
						[MJ_BING] = {},
						[MJ_FENG] = {},
						[MJ_ZFB]  = {}
					}
	pai  = SortByType(userpai)

	-- 间接递归检测是否胡
	isHu = ValidHu( pai[MJ_WAN],1,#pai[MJ_WAN])   and
		   ValidHu( pai[MJ_TIAO],1,#pai[MJ_TIAO])  and
		   ValidHu( pai[MJ_BING],1,#pai[MJ_BING])  and
	       ValidHu_p( pai[MJ_FENG],1,#pai[MJ_FENG]) and
	       ValidHu_p( pai[MJ_ZFB],1,#pai[MJ_ZFB])

	return isHu;

end


-------------------------------------- 测试代码 -----------------------------------------
local pai_list = {
				{11,11},
				{11,11,11},
				{11,11,11,11},
				{11,12,13},
				{11,12,13,14},
				{11,12,12,12,13},		--特殊
				{11,22,23,24,25},
				{51,51,51},
				{51,52,53}
}

for i = 1,#pai_list,1 do
	for j = 1,#pai_list[i],1 do
		io.write(pai_list[i][j],',')
	end
	if CheckHu(pai_list[i]) then
		print("胡")
	else
		print("不能胡")
	end
	io.write('\n')
end
