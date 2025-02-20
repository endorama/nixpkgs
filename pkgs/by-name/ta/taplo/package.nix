{
  lib,
  rustPlatform,
  fetchCrate,
  pkg-config,
  openssl,
  stdenv,
  darwin,
  withLsp ? true,
}:

rustPlatform.buildRustPackage rec {
  pname = "taplo";
  version = "0.9.3";

  src = fetchCrate {
    inherit version;
    pname = "taplo-cli";
    hash = "sha256-dNGQbaIfFmgXh2AOcaE74BTz7/jaiBgU7Y1pkg1rV7U=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-7u7ZyS+5QIGfXKNVJZLzGXoMSI2DHSrD1AEtPttS22Q=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs =
    [
      openssl
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.SystemConfiguration
    ];

  buildFeatures = lib.optional withLsp "lsp";

  meta = with lib; {
    description = "TOML toolkit written in Rust";
    homepage = "https://taplo.tamasfe.dev";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
    mainProgram = "taplo";
  };
}
