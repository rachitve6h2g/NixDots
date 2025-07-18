{ config, ... }:
let
  color = config.lib.stylix.colors;
in
{
  xdg.configFile."rmpc/themes/theme.ron".text =
    #ron
    ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
          default_album_art_path: None,
          show_song_table_header: true,
          draw_borders: true,
          browser_column_widths: [20, 38, 42],
          background_color: "#${color.base00}",
          modal_backdrop: true,
          text_color: "#${color.base05}",
          header_background_color: "#${color.base00}",
          modal_background_color: "#${color.base00}",
          preview_label_style: (fg: "#${color.base0D}"),
          preview_metadata_group_style: (fg: "#${color.base0C}"),
          tab_bar: (
              enabled: true,
              active_style: (fg: "#${color.base00}", bg: "#${color.base09}", modifiers: "Bold"),
              inactive_style: (fg: "#${color.base05}", bg: "#${color.base00}", modifiers: ""),
          ),
          highlighted_item_style: (fg: "#${color.base0E}", modifiers: "Bold"),
          current_item_style: (fg: "#${color.base00}", bg: "#${color.base09}", modifiers: "Bold"),
          borders_style: (fg: "#${color.base09}", modifiers: "Bold"),
          highlight_border_style: (fg: "#${color.base09}"),
          symbols: (song: "󰝚 ", dir: " ", playlist: "󰲸 ", marker: "* ", ellipsis: "..."),
          progress_bar: (
              symbols: ["█", "█", "█", "█", "█"],
              track_style: (fg: "#3b4252"),
              elapsed_style: (fg: "#${color.base09}"),
              thumb_style: (fg: "#${color.base09}"),
          ),
          scrollbar: (
              symbols: ["│", "█", "▲", "▼"],
              track_style: (fg: "#${color.base09}"),
              ends_style: (fg: "#${color.base09}"),
              thumb_style: (fg: "#${color.base09}"),
          ),
          song_table_format: [
              (
                  prop: (kind: Property(Artist), style: (fg: "#${color.base09}"),
                      default: (kind: Text("Unknown"), style: (fg: "#${color.base0D}"))
                  ),
                  width: "20%",
              ),
              (
                  prop: (kind: Property(Title), style: (fg: "#${color.base0C}"),
                      highlighted_item_style: (fg: "#${color.base05}", modifiers: "Bold"),
                      default: (kind: Property(Filename), style: (fg: "#${color.base05}"),)
                  ),
                  width: "35%",
              ),
              (
                  prop: (kind: Property(Album), style: (fg: "#${color.base09}"),
                      default: (kind: Text("Unknown Album"), style: (fg: "#${color.base0D}"))
                  ),
                  width: "30%",
              ),
              (
                  prop: (kind: Sticker("playCount"), default: (kind: Text("0"))),
                  width: "9",
                  alignment: Right,
                  label: "Playcount"
              ),
              (
                  prop: (kind: Property(Duration), style: (fg: "#${color.base0C}"),
                      default: (kind: Text("-"))
                  ),
                  width: "15%",
                  alignment: Right,
              ),
          ],
          layout: Split(
              direction: Vertical,
              panes: [
                  (
                      size: "3",
                      pane: Pane(Tabs),
                  ),
                  (
                      size: "4",
                      pane: Split(
                          direction: Horizontal,
                          panes: [
                              (
                                  size: "100%",
                                  pane: Split(
                                      direction: Vertical,
                                      panes: [
                                          (
                                              size: "4",
                                              borders: "ALL",
                                              pane: Pane(Header),
                                          ),
                                      ]
                                  )
                              ),
                          ]
                      ),
                  ),
                  (
                      size: "100%",
                      pane: Split(
                          direction: Horizontal,
                          panes: [
                              (
                                  size: "100%",
                                  borders: "NONE",
                                  pane: Pane(TabContent),
                              ),
                          ]
                      ),
                  ),
                  (
                      size: "3",
                      borders: "TOP | BOTTOM",
                      pane: Pane(ProgressBar),
                  ),
              ],
          ),
          header: (
              rows: [
                  (
                      left: [
                          (kind: Text(""), style: (fg: "#${color.base09}", modifiers: "Bold")),
                          (kind: Property(Status(StateV2(playing_label: "  ", paused_label: "  ", stopped_label: "  ")))),
                          (kind: Text(" "), style: (fg: "#${color.base09}", modifiers: "Bold")),
                          (kind: Property(Widget(ScanStatus)))

                      ],
                      center: [
                          (kind: Property(Song(Title)), style: (fg: "#${color.base05}",modifiers: "Bold"),
                              default: (kind: Property(Song(Filename)), style: (fg: "#${color.base05}",modifiers: "Bold"))
                          )
                      ],
                      right: [
                          (kind: Text("󱡬"), style: (fg: "#${color.base09}", modifiers: "Bold")),
                          (kind: Property(Status(Volume)), style: (fg: "#${color.base05}", modifiers: "Bold")),
                          (kind: Text("%"), style: (fg: "#${color.base09}", modifiers: "Bold"))
                      ]
                  ),
                  (
                      left: [
                          (kind: Text("[ "),style: (fg: "#${color.base09}", modifiers: "Bold")),
                          (kind: Property(Status(Elapsed)),style: (fg: "#${color.base05}")),
                          (kind: Text(" / "),style: (fg: "#${color.base09}", modifiers: "Bold")),
                          (kind: Property(Status(Duration)),style: (fg: "#${color.base05}")),
                          (kind: Text(" | "),style: (fg: "#${color.base09}")),
                          (kind: Property(Status(Bitrate)),style: (fg: "#${color.base05}")),
                          (kind: Text(" kbps"),style: (fg: "#${color.base09}")),
                          (kind: Text("]"),style: (fg: "#${color.base09}", modifiers: "Bold"))
                      ],
                      center: [
                          (kind: Property(Song(Artist)), style: (fg: "#${color.base0C}", modifiers: "Bold"),
                              default: (kind: Text("Unknown Artist"), style: (fg: "#${color.base0C}", modifiers: "Bold"))
                          ),
                          (kind: Text(" - ")),
                          (kind: Property(Song(Album)),style: (fg: "#${color.base09}" ),
                              default: (kind: Text("Unknown Album"), style: (fg: "#${color.base09}", modifiers: "Bold"))
                          )
                      ],
                      right: [
                          (kind: Text("[ "),style: (fg: "#${color.base09}")),
                          (kind: Property(Status(RepeatV2(
                                          on_label: "", off_label: "",
                                          on_style: (fg: "#${color.base05}", modifiers: "Bold"), off_style: (fg: "#${color.base03}", modifiers: "Bold"))))),
                          (kind: Text(" | "),style: (fg: "#${color.base09}")),
                          (kind: Property(Status(RandomV2(
                                          on_label: "", off_label: "",
                                          on_style: (fg: "#${color.base05}", modifiers: "Bold"), off_style: (fg: "#${color.base03}", modifiers: "Bold"))))),
                          (kind: Text(" | "),style: (fg: "#${color.base09}")),
                          (kind: Property(Status(ConsumeV2(
                                          on_label: "󰮯", off_label: "󰮯", oneshot_label: "󰮯󰇊",
                                          on_style: (fg: "#${color.base05}", modifiers: "Bold"), off_style: (fg: "#${color.base03}", modifiers: "Bold"))))),
                          (kind: Text(" | "),style: (fg: "#${color.base09}")),
                          (kind: Property(Status(SingleV2(
                                          on_label: "󰎤", off_label: "󰎦", oneshot_label: "󰇊", off_oneshot_label: "󱅊",
                                          on_style: (fg: "#${color.base05}", modifiers: "Bold"), off_style: (fg: "#${color.base03}", modifiers: "Bold"))))),
                          (kind: Text(" ]"),style: (fg: "#${color.base09}")),
                      ]
                  ),
              ],
          ),
          browser_song_format: [
              (
                  kind: Group([
                          (kind: Property(Track)),
                          (kind: Text(" ")),
                      ])
              ),
              (
                  kind: Group([
                          (kind: Property(Artist)),
                          (kind: Text(" - ")),
                          (kind: Property(Title)),
                      ]),
                  default: (kind: Property(Filename))
              ),
          ],
      )

    '';
}
