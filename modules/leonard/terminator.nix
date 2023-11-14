{
  programs.terminator = {
    enable = true;
    # see man terminator_config(5)
    config = {
      global_config = {
        handle_size = 0;
        window_state = "maximise";
        borderless = true;
      };
      profiles = rec {
        default = {
          scrollback_infinite = true;
        } // theme-3024-night;
        # Source for themes: https://github.com/EliverLara/terminator-themes/tree/master/schemes
        theme-3024-night = {
          palette = "#090300:#db2d20:#01a252:#fded02:#01a0e4:#a16a94:#b5e4f4:#a5a2a2:#5c5855:#e8bbd0:#3a3432:#4a4543:#807d7c:#d6d5d4:#cdab53:#f7f7f7";
          background_color = "#090300";
          cursor_color = "#a5a2a2";
          foreground_color = "#a5a2a2";
          background_image = null;
        };
        theme-3024-day = {
          palette = "#090300:#db2d20:#01a252:#fded02:#01a0e4:#a16a94:#b5e4f4:#a5a2a2:#5c5855:#e8bbd0:#3a3432:#4a4543:#807d7c:#d6d5d4:#cdab53:#f7f7f7";
          background_color = "#f7f7f7";
          cursor_color = "#4a4543";
          foreground_color = "#4a4543";
          background_image = null;
        };
      };
    };
  };
}
