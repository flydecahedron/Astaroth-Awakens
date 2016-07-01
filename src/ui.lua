local suit = require("libs.suit")
local ui = {}
function ui.update()
  --put layout origin at position
  suit.layout:reset(100,500)
  suit.layout:padding(10,10)
-- construct a cell of size 300x30 px and put the button into it
  if suit.Button("<(-_-)>", suit.layout:row(300,30)).hit then
    show_message = true
  end
  if show_message then
    if suit.Button("..\\.. [o> ~ <o] ../..", suit.layout:row())then
    end
  end
end

function ui.draw()
  suit.draw()
end

return ui
