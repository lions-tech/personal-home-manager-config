final: prev:

let
  plistMinimal = { app-name, version }: ''
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
        <key>CFBundleIconFile</key>
        <string>Icon.icns</string>
        <key>CFBundleIconName</key>
        <string>Icon.icns</string>
    </dict>
    </plist>    
  '';

  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/audio/grandorgue/default.nix
  macOsBundleScript = { bin-name, app-name, version, svg-path }: ''
    mkdir -p $out/Applications/${app-name}.app/Contents/MacOS
    ln -s "$out/bin/${bin-name}" "$out/Applications/${app-name}.app/Contents/MacOS/${app-name}"
    echo "${plistMinimal { inherit app-name version; }}" > "$out/Applications/${app-name}.app/Contents/Info.plist"
    #${svg2icns} ${svg-path}
    #mkdir -p $out/Applications/${app-name}.app/Contents/Resources
    #mv *.icns $out/Applications/${app-name}.app/Contents/Resources/Icon.icns
  '';

  svg2icns = final.writeShellScript "svg2icns" ''
    # SOURCE: https://gist.github.com/adriansr/1da9b18a8076b0f8a977a5eea0ae41ef
    
    set -e

    export HOME="/Users/homeless-shelter"
    
    SIZES="
    16,16x16
    32,16x16@2x
    32,32x32
    64,32x32@2x
    128,128x128
    256,128x128@2x
    256,256x256
    512,256x256@2x
    512,512x512
    1024,512x512@2x
    "
    
    for SVG in "$@"; do
        BASE=$(basename "$SVG" | sed 's/\.[^\.]*$//')
        ICONSET="$BASE.iconset"
        mkdir -p "$ICONSET"
        for PARAMS in $SIZES; do
            SIZE=$(echo $PARAMS | cut -d, -f1)
            LABEL=$(echo $PARAMS | cut -d, -f2)
            ${final.inkscape}/bin/inkscape -w $SIZE -h $SIZE "$SVG" -o "$ICONSET"/icon_$LABEL.png
        done
    
        ${final.libicns}/bin/png2icns Icon.icns "$ICONSET"/*.png
        rm -r "$ICONSET"
    done
  '';
in
{
  cherrytree = prev.cherrytree.overrideAttrs (old: {
    postInstall = macOsBundleScript {
      bin-name = "cherrytree";
      app-name = "Cherrytree";
      version = old.version;
      svg-path = "${old.src}/icons/cherrytree.svg";
    };
  });
}
