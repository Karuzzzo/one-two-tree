--[[
    GD50
    Breakout Remake

    -- Powerup Class --
]]

Powerup = Class{}

function Powerup:init(x, y, skin)
    -- simple positional and dimensional variables
    self.x = x
    self.y = y
    -- this variable is for keeping track of y velocity 
    self.dy = 40

    self.height = 16
    self.width = 16
    
    self.inPlay = true
    -- this will effectively be the color, defining effect of our Powerup, and we will index
    -- our table of Quads relating to the global block texture using this
    self.skin = skin
end

--[[
    Expects an argument with a bounding box, be that a paddle or a brick,
    and returns true if the bounding boxes of this and the argument overlap.
    Powerup is box, so AABB
]]
function Powerup:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function Powerup:update(dt)
    self.y = self.y + self.dy * dt
end

function Powerup:render()
    if self.inPlay then
    -- gTexture is our global texture for all blocks
    -- gBallFrames is a table of quads mapping to each individual ball skin in the texture
        love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin],
            self.x, self.y)
    end
end