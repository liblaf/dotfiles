-- ref: <https://github.com/sxyazi/yazi/blob/shipped/yazi-plugin/preset/components/status.lua>

require("full-border"):setup()
require("git"):setup()
require("starship"):setup()

Status:children_add(
  function()
    local h = cx.active.current.hovered
    if not h then
      return
    end
    if h.cha.is_dir then
      return ui.Line(
        {
          ui.Span(" "),
          ui.Span(string.format("%6s", "-")):dim()
        }
      )
    end
    local size = h:size() or h.cha.len
    local pretty_size = ya.readable_size(size)
    return ui.Line(
      {
        ui.Span(" "),
        ui.Span(string.format("%6s", pretty_size)):fg("green")
      }
    )
  end,
  1100,
  Status.RIGHT
)

Status:children_add(
  function()
    local h = cx.active.current.hovered
    if not h or not h.cha or not h.cha.uid then
      return
    end
    local pretty_uid = ya.user_name(h.cha.uid) or tostring(h.cha.uid)
    return ui.Line(
      {
        ui.Span(" "),
        ui.Span(pretty_uid):fg("yellow")
      }
    )
  end,
  1200,
  Status.RIGHT
)

Status:children_add(
  function()
    local h = cx.active.current.hovered
    if not h or not h.cha or not h.cha.mtime then
      return
    end
    ---@type string
    ---@diagnostic disable-next-line: assign-type-mismatch
    local mtime = os.date("%F %T", math.tointeger(h.cha.mtime))
    return ui.Line(
      {
        ui.Span(" "),
        ui.Span(mtime):fg("blue")
      }
    )
  end,
  1300,
  Status.RIGHT
)
