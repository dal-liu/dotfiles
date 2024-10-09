# pyright: reportMissingImports=false
from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb, draw_title
from kitty.utils import color_as_int


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    tab_fg = screen.cursor.fg
    left_sep, right_sep = (" ", "")
    tab_bg = screen.cursor.bg
    default_bg = as_rgb(color_as_int(draw_data.default_bg))

    def draw_sep(which: str) -> None:
        screen.cursor.bg = default_bg
        screen.cursor.fg = tab_bg
        screen.draw(which)
        screen.cursor.bg = tab_bg
        screen.cursor.fg = tab_fg

    max_tab_length += 1
    if max_tab_length <= 1:
        screen.draw("…")
    elif max_tab_length == 2:
        screen.draw("…|")
    elif max_tab_length < 6:
        draw_sep(left_sep)
        screen.draw(
            (" " if max_tab_length == 5 else "")
            + "…"
            + (" " if max_tab_length >= 4 else "")
        )
        draw_sep(right_sep)
    else:
        draw_sep(left_sep)
        screen.draw(" ")
        draw_title(draw_data, screen, tab, index, max_tab_length)
        extra = screen.cursor.x - before - max_tab_length
        if extra >= 0:
            screen.cursor.x -= extra + 3
            screen.draw("…")
        elif extra == -1:
            screen.cursor.x -= 2
            screen.draw("…")
        screen.draw(" ")
        draw_sep(right_sep)

    return screen.cursor.x
