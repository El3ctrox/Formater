--// Consts
local COMMA_SUFFIXES = {"k","M","B","T"}

local ROMAN_INDEXES = {1000,500,100,50,10,5,1}
local ROMAN_CHARACTERS = {"M","D","C","L","X","V","I"}

--// Functions
local function div(num,div)
	return math.floor(num/div),num%div
end

--// Module
local Formater = {}

--// Module Functions
function Formater.ToComma(number)
	
	local text = tostring(  math.floor(number)  )
	
	if #text > 3 then
		
		local suffix = math.floor(  (#text-1)/3  )
		local case = math.ceil(  #text % 3.1  )
		
		local case2 = text:sub(case+1,case+1)
		
		return text:sub(1,case)  .. (case2 == "0" and "" or "," .. case2) .. COMMA_SUFFIXES[suffix]
		
	else
		local fullText 	= tostring(number)
		local case2		= fullText:sub(#text+2,#text+2)
		
		local result = fullText:sub(1,#text)
		
		if case2 ~= "" then
			result ..= ","..case2
		end
		
		return result
	end
	
end

function Formater.ToRomanNumber(number)
	local ret = ""

	local fakeNum = number

	local lastChar = ""

	for i,num in next,ROMAN_INDEXES do
		local char = ROMAN_CHARACTERS[i]

		local result,rest = div(fakeNum,num)

		if result < 4 then
			for i = 1,result do
				ret ..= char
			end
		else
			local UpChar = ROMAN_CHARACTERS[i-1]

			if lastChar == UpChar then
				ret = ret:sub(1,#ret-1) .. char .. ROMAN_CHARACTERS[i-2]
			else
				ret ..= char .. UpChar
			end
		end

		fakeNum = rest

		if result > 0 then
			lastChar = char
		end
	end

	return ret
end

--// End
return Formater
