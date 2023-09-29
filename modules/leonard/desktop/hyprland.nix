{ pkgs, ... }:

{

  programs.wofi.enable = true;

  # inspired by @fufexan and default config
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      env = [
        "_JAVA_AWT_WM_NONREPARENTING,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];

      # use this instead of hidpi patches
      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        # disable auto polling for config file changes
        disable_autoreload = true;

        disable_hyprland_logo = true;
        disable_splash_rendering = true;

        # disable dragging animation
        animate_mouse_windowdragging = false;

        # enable variable refresh rate (effective depending on hardware)
        vrr = 1;

        # groupbar
        groupbar_titles_font_size = 16;
        groupbar_gradients = false;
      };

      touchpad = {
        natural_scroll = "yes";
      };

      # touchpad gestures
      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      input = {
        kb_layout = "de";
        follow_mouse = 1;
        accel_profile = "flat";
      };

      monitor = [
        ",preferred,auto,auto"
        "DP-3,1920x1080@60,0x0,1"
        "DP-2,1920x1080@60,1920x0,1,transform,3"
        "eDP-1,preferred,3000x0,1"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        # keep floating dimentions while tiling
        pseudotile = true;
        preserve_split = true;
      };


      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [

        "$mod SHIFT, Q, exit,"
        "$mod SHIFT, C, killactive,"
        "$mod, F, togglefloating,"

        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        "$mod, P, exec, wofi --show drun"
        "$mod SHIFT, RETURN, exec, terminator"
      ]
      # binds mod + [shift +] {1..10} to [move to] ws {1..10}
      ++ (builtins.genList
        (
          x:
          let
            ws =
              let
                c = (x + 1) / 10;
              in
              builtins.toString (x + 1 - (c * 10));
          in
          ''
            bind = $mod, ${ws}, workspace, ${toString (x + 1)}
            bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
          ''
        )
        10);
    };
  };
}
