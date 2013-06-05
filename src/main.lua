local function shouldOpenInRound(number, round)
	if round == 0 then return false end
	
	if number % round == 0 then
		return not shouldOpenInRound(number, round-1)
	end
	
	return shouldOpenInRound(number, round-1)
end

local function doors(numDoors, round)
	local doors = {}
	
	for i = 1, numDoors do
		table.insert(doors,shouldOpenInRound(i, round))
	end
	
	return doors
end

describe("How many numbers less than or equal to ROUND can divide NUMBER, is this an odd number?", function()
	it("0 is a special case where it should be false", function()
		assert.is_false(shouldOpenInRound(1,0))
	end)
	
	it("1 can divide 1", function()
		assert.is_true(shouldOpenInRound(1,1))
	end)
	
	it("1,2 can divide 2", function()
		assert.is_false(shouldOpenInRound(2,2))
	end)
	
	it("1,3 can divide 3", function()
		assert.is_false(shouldOpenInRound(3,3))
	end)
	
	it("1,2 can divide 4", function()
		assert.is_false(shouldOpenInRound(4,2))
	end)
	
	it("1,2,4 can divide 4", function()
		assert.is_true(shouldOpenInRound(4,4))
	end)
end)

describe("100 doors kata", function()
	it("All doors closed at the beginning", function()
		local doors = doors(100,0)
		
		for i,door in ipairs(doors) do
			assert.is_false(door)
		end
	end)

	it("All doors open after the first round", function()
		local doors = doors(100,1)
		
		for i,door in ipairs(doors) do
			assert.is_true(door)
		end
	end)

	it("Second round, alternative doors are open", function()
		local doors = doors(100,2)
		
		for i= 1,100, 2 do assert.is_true(doors[i]) end
		for i= 2,100, 2 do assert.is_false(doors[i]) end
	end)

	it("Third round, [1 0 0 0 1 1]", function()
		local doors = doors(6,3)

		assert.is_true(doors[1])
		assert.is_false(doors[2])
		assert.is_false(doors[3])
		assert.is_false(doors[4])
		assert.is_true(doors[5])
		assert.is_true(doors[6])
	end)
	
	it("100th round, 1,4,9,16...100", function()
		local doors = doors(100,100)
		
		for i=1,100 do
			if math.sqrt(i) == math.ceil(math.sqrt(i)) then 
				assert.is_true(doors[i]) 
			else 
				assert.is_false(doors[i]) 
			end
		end
	end)
end)