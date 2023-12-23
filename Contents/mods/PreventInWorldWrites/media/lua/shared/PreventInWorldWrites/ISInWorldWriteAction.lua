require "TimedActions/ISBaseTimedAction"

ISInWorldWriteAction = ISBaseTimedAction:derive("ISInWorldWriteAction")

function ISInWorldWriteAction:isValid()
	return true
end

function ISInWorldWriteAction:update()
end

function ISInWorldWriteAction:start()
end

function ISInWorldWriteAction:stop()
	ISBaseTimedAction.stop(self)
end

function ISInWorldWriteAction:perform()
	ISInventoryPaneContextMenu.onWriteSomething(self.item, true, self.playerIndex)
	ISBaseTimedAction.perform(self)
end

function ISInWorldWriteAction:new(playerIndex, char, item)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	-- Required fields
	o.playerIndex = playerIndex
	o.character = char
	o.stopOnWalk = false
	o.stopOnRun = false
	o.stopOnAim = false
	o.maxTime = 0;
	o.item = item;
	return o
end

