{ inputs, ... }:
{
  imports = [
    inputs.git-hooks.flakeModule
  ];
  perSystem =
    { config, ... }:
    {
      pre-commit = {
        check.enable = true;
        settings = {
          hooks = {
            editorconfig-checker = {
              enable = true;
              excludes = [
                ".*-lib-table"
                ".*.kicad_.*"
                "flake.lock"
              ];
            };
            markdownlint = {
              enable = true;
              settings.configuration = {
                MD013 = false;
                MD026 = false;
              };
            };
            treefmt = {
              enable = true;
              package = config.treefmt.build.wrapper;
            };
          };
          src = ./.;
        };
      };
    };
}
