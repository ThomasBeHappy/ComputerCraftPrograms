local shatter = require("shatter") -- Load the shatter API
local mods = peripheral.wrap("back") -- get the modules list
if not mods.canvas then -- ensure glasses are present
  error("Overlay Glasses required") -- error if they aren't there
end
_G.glasses, handler = shatter(mods.canvas()) -- get the terminal object, and put it in the global scope (for alpha setting [and more!] in the shell)
parallel.waitForAll(handler, -- put the handler function in parallel
function()
  term.redirect(glasses) -- redirect to overlay
  glasses.setBackgroundAlpha(.4) -- set the alpha value of the background to .4, for visibility.
  term.clear() -- apply the alpha value change
  if multishell then -- if an advanced computer run multishell
    shell.run("/rom/programs/advanced/multishell.lua")
  else -- otherwise run the shell
    shell.run("shell")
  end
end,
function()
  while true do
    os.pullEvent("shatter_resize") -- check for when the glasses get resized
    os.queueEvent("term_resize") -- apply it to the shell terminal
  end
end)