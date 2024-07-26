{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    terminal = "xterm-256color";
    baseIndex = 1;
    keyMode = "emacs";
    shortcut = "q";
    mouse = true;
    clock24 = true;
    escapeTime = 1;
    extraConfig = ''
      # split panes using | and -, make sure they open in the same path
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      unbind '"'
      unbind %

      # open new windows in the current path
      bind c new-window -c "#{pane_current_path}"

      # reload config file
      bind r source-file ~/.tmux.conf

      unbind p
      bind p previous-window

      # don't rename windows automatically
      set -g allow-rename off

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # set default terminal mode to 256 colors
      set -ga terminal-overrides ",xterm-256color:Tc"

      # present a menu of URLs to open from the visible pane. sweet.
      bind u capture-pane \;\
          save-buffer /tmp/tmux-buffer \;\
          split-window -l 10 "urlview /tmp/tmux-buffer"


      ######################
      ### DESIGN CHANGES ###
      ######################

      # loud or quiet?
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

      #  modes
      setw -g clock-mode-colour colour1
      setw -g mode-style 'fg=colour0 bg=colour1 bold'

      # panes
      set -g pane-border-style 'fg=colour1'
      set -g pane-active-border-style 'fg=colour3'

      # statusbar
      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'fg=colour1'
      set -g status-left ""
      set -g status-right '%Y-%m-%d %H:%M '
      set -g status-right-length 50
      set -g status-left-length 10

      setw -g window-status-current-style 'fg=colour0 bg=colour1 bold'
      setw -g window-status-current-format ' #I #W #F '
      setw -g window-status-style 'fg=colour1 dim'
      setw -g window-status-format ' #I #[fg=colour7]#W #[fg=colour1]#F '
      setw -g window-status-bell-style 'fg=colour2 bg=colour1 bold'

      # messages
      set -g message-style 'fg=colour2 bg=colour0 bold'
    '';
  };
}
