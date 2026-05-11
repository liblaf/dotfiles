-- ref: <https://yazi-rs.github.io/docs/configuration/yazi#mgr.linemode>
function Linemode:size_and_mtime()
  local time = math.floor(self._file.cha.mtime or 0)
  if time == 0 then
    time = ""
  else
    time = os.date("%Y-%m-%d %H:%M:%S", time)
  end

  local size = self._file:size()
  return string.format("%s %s", size and ya.readable_size(size) or "", time)
end

-- ref: <https://yazi-rs.github.io/docs/tips#symlink-in-status>
Status:children_add(
  function(self)
    local h = self._current.hovered
    if h and h.link_to then
      return " -> " .. tostring(h.link_to)
    else
      return ""
    end
  end,
  3300,
  Status.LEFT
)

-- ref: <https://yazi-rs.github.io/docs/tips#user-group-in-status>
Status:children_add(
  function()
    local h = cx.active.current.hovered
    if not h or ya.target_family() ~= "unix" then
      return ""
    end

    return ui.Line {
      ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
      ":",
      ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
      " "
    }
  end,
  500,
  Status.RIGHT
)

-- ref: <https://github.com/yazi-rs/plugins/tree/main/full-border.yazi>
require("full-border"):setup()

-- ref: <https://github.com/yazi-rs/plugins/tree/main/git.yazi>
require("git"):setup {
  -- Order of status signs showing in the linemode
  order = 1500
}
