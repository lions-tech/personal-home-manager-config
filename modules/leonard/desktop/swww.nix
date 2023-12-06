{ pkgs, ... }:

{
  home.packages = [ pkgs.swww ];


  systemd.user = {
    /*
       Not working, currently.
       Seems like swww can't create the /run/user/NNNN/swww.socket file
       Currently executing swww via Hyprland

       services.swww = {
         Unit.Description = "swww";
         Service = {
           Type = "forking";
           ExecStart = "${pkgs.strace}/bin/strace ${pkgs.swww}/bin/swww init";
           ExecStop = "${pkgs.swww}/bin/swww kill";
         };
          Install.WantedBy = [ "graphical-session.target" ];
                    };
    */

    services.swww-wallpaper-changer = {
      Unit = {
        Description = "Change wallpaper using swww";
      };
      Service.ExecStart = toString (
        pkgs.writeShellScript "wallpaper-changer-script" ''
          image="$(${pkgs.findutils}/bin/find ${pkgs.wallpapers} -type f | ${pkgs.coreutils}/bin/shuf -n 1)"
          ${pkgs.swww}/bin/swww img $image --transition-type wipe --transition-step 255 --transition-fps 255
        ''
      );
      #Install.Wants = [ "swww.service" ];
    };


    timers.swww-wallpaper-changer = {
      Unit.Description = "Timer for changing wallpaper using swww";
      Install.WantedBy = [ "timers.target" ];
      Timer = {
        OnCalendar = "hourly";
        Unit = "swww-wallpaper-changer.service";
        Persistent = true;
      };
    };
  };
}
