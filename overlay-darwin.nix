final: prev:

let
  plistMinimal = app-name: version: ''
    <?xml version="1.0" encoding="UTF-8" standalone="no"?><plist version="1.0">
      <dict>
        <key>CFBundleExecutable</key>
        <string>${app-name}</string>
        <key>CFBundleGetInfoString</key>
        <string>${app-name} ${version}</string>
        <key>CFBundleVersion</key>
        <string>${version}</string>
        <key>CFBundleShortVersionString</key>
        <string>${version}</string>
    </dict>
    </plist>    
  '';

  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/audio/grandorgue/default.nix
  # https://gist.github.com/adriansr/1da9b18a8076b0f8a977a5eea0ae41efaf
  macOsBundleScript = bin-name: app-name: version: svg-path: ''
    mkdir -p $out/Applications/${app-name}.app/Contents/MacOS
    ln -s "$out/bin/${bin-name}" "$out/Applications/${app-name}.app/Contents/MacOS/${app-name}"
    echo "${plistMinimal app-name version}" > "$out/Applications/${app-name}.app/Contents/Info.plist"
  '';
in
{
  cherrytree = prev.cherrytree.overrideAttrs (old: {
    postInstall = macOsBundleScript "cherrytree" "Cherrytree" old.version "${old.src}/icons/cherrytree.svg";
  });
}
