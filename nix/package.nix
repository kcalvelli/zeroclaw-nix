{ lib
, rustPlatform
, pkg-config
, openssl
, systemd
, zeroclaw-web ? null
}:

rustPlatform.buildRustPackage {
  pname = "zeroclaw";
  version = "0.6.8";
  src = ./..;

  cargoHash = "sha256-/Uu+AlhFgmCymYPTs6K4Ffd0TfILCiymYkVgL9tZ1zU=";

  postPatch = lib.optionalString (zeroclaw-web != null) ''
    rm -rf web/dist
    ln -s ${zeroclaw-web} web/dist
  '';

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl systemd ];

  doCheck = false;

  meta = {
    description = "Zero overhead AI assistant";
    homepage = "https://github.com/kcalvelli/zeroclaw-nix";
    license = with lib.licenses; [ mit asl20 ];
    mainProgram = "zeroclaw";
  };
}
