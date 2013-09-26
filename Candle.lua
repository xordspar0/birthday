Candle = {}
Candle.x = 0
Candle.y = 0
Candle.lit = true

function Candle:new(x, y)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.x = x
    o.y = y
    return o
end

function Candle:isLit()
    return self.lit
end
