local Stack = {}

Stack.__index = Stack
local IDCounter = 0

function Stack:new()
    local temp = {_Stack = {__mode = "kv"} }
    IDCounter = IDCounter + 1
    setmetatable(temp,self)
    return temp
end

function Stack:Pop()
    if #(self._Stack) == 0 then
        error("Stack is empty.",2)
    end
    return table.remove(self._Stack,#self._Stack)
end

function Stack:Push(t)
    table.insert(self._Stack,t)
end

function Stack:Count()
    return #self._Stack
end

function Stack:IsEmpty()
    if self:Count() == 0 then
        return true
    else
        return false
    end
end

function Stack:Top()
   if #(self._Stack)==0 then
      error("Stack is empty.",2)
   end
   return self._Stack[#self._Stack]
end

return Stack
