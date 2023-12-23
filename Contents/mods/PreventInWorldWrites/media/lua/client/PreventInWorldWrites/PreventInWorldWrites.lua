PreventInWorldWrites = PreventInWorldWrites or {}

function PreventInWorldWrites.OnFillInventoryObjectContextMenu(playerIndex, context, items)
    local player = getSpecificPlayer(playerIndex)
    local writeOption = nil
    for _,option in ipairs(context.options) do
        if option.onSelect == ISInventoryPaneContextMenu.onWriteSomething and option.param1 then
            writeOption = option
            break
        end
    end
    if writeOption then
        local item = writeOption.target
        if not instanceof(item, "InventoryItem") or not item:isInPlayerInventory() then
            writeOption.name = getText("ContextMenu_Read_Note", item:getName())
            writeOption.param1 = false
            context:insertOptionAfter(writeOption.name, getText("ContextMenu_PickupToWrite", item:getName()), items, PreventInWorldWrites.onGrabAndWrite, playerIndex, item)
        end
    end
end

function PreventInWorldWrites.onGrabAndWrite(items, playerIndex, item)
    ISInventoryPaneContextMenu.onGrabItems(items, playerIndex)
    ISTimedActionQueue.add(ISInWorldWriteAction:new(playerIndex, getSpecificPlayer(playerIndex), item))
end

Events.OnFillInventoryObjectContextMenu.Add(PreventInWorldWrites.OnFillInventoryObjectContextMenu)