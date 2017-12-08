local function AddTriple(taskset)
	-- check if caves, if so then exit
	if taskset.location ~= "forest" then
		return
	end
	-- add triple tusk if it doesn't exist in the tasks to be executed
	local has_triple = false
	for _,i in pairs(taskset.tasks) do
		if i == "The hunters" then
			has_triple = true
			break
		end
	end
	if not has_triple then
		table.insert(taskset.tasks, "The hunters")
	end
	-- remove triple tusk if it is in optional tasks
	for index,i in pairs(taskset.optionaltasks) do
		if i == "The hunters" then
			table.remove(taskset.optionaltasks, index)
			taskset.numoptionaltasks = taskset.numoptionaltasks - 1
			break
		end
	end
end

-- modify any task sets
AddTaskSetPreInitAny(AddTriple)