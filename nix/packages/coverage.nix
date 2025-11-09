{
  pkgs,
  haskellPackages,
  ghcVersion,
}: let
  # Apply coverage overlay to get packages with coverage enabled
  hpkgs = haskellPackages.extend (import ../overlays/haskell/coverage.nix pkgs);

  # The main package we're generating coverage for
  sdkPackage = hpkgs.temporal-sdk;

  # Tool to convert .tix files to markdown
  tixToMarkdown = hpkgs.tix-to-markdown;
in
  pkgs.stdenv.mkDerivation {
    name = "temporal-sdk-coverage-${ghcVersion}";

    buildInputs = [
      hpkgs.ghc
      pkgs.haskellPackages.hpc
      tixToMarkdown
    ];

    phases = ["buildPhase" "installPhase"];

    buildPhase = ''
          echo "Building coverage report for temporal-sdk..."
          echo "SDK package: ${sdkPackage}"

          # Create directories
          mkdir -p coverage

          # The doCoverage function already generates HTML coverage reports
          # We just need to copy them from the package
          if [ -d "${sdkPackage}/share/hpc/vanilla/html" ]; then
            echo "Found pre-generated HPC HTML report"
            cp -rv "${sdkPackage}/share/hpc/vanilla/html" coverage/

            # Make the directory writable so we can create symlinks
            chmod -R u+w coverage/html

            # Create index.html symlink to hpc_index.html for easier access
            if [ -f "coverage/html/hpc_index.html" ]; then
              ln -sf hpc_index.html coverage/html/index.html
            fi

            echo "Coverage HTML report copied successfully!"
          else
            echo "Warning: No coverage HTML found in ${sdkPackage}"
            mkdir -p coverage/html
            cat > coverage/html/index.html <<EOF
      <!DOCTYPE html>
      <html>
      <head><title>No Coverage Data</title></head>
      <body>
      <h1>No Coverage Data Available</h1>
      <p>No coverage report was found in the package.</p>
      <p>Package checked: ${sdkPackage.pname}</p>
      </body>
      </html>
      EOF
          fi

          # Also copy .tix files for reference
          if [ -d "${sdkPackage}/share/hpc/vanilla/tix" ]; then
            echo "Copying .tix files..."
            mkdir -p coverage/tix
            cp -v "${sdkPackage}"/share/hpc/vanilla/tix/*.tix coverage/tix/ 2>&1 || true
          fi

          # Find the mix directory - it's in a versioned library path
          tix_file="${sdkPackage}/share/hpc/vanilla/tix/temporal-sdk-tests.tix"
          mix_dir=$(find "${sdkPackage}/lib" -type d -name "mix" -path "*/extra-compilation-artifacts/hpc/*/mix" | head -1)

          if [ -f "$tix_file" ] && [ -d "$mix_dir" ]; then
            echo "Found .tix file: $tix_file"
            echo "Found .mix directory: $mix_dir"

            echo "Generating text coverage summary..."
            ${hpkgs.ghc}/bin/hpc report \
              --hpcdir="$mix_dir" \
              "$tix_file" > coverage/report.txt 2>&1 || echo "Note: Could not generate text report"

            if [ -f coverage/report.txt ] && [ -s coverage/report.txt ]; then
              echo "Coverage summary:"
              cat coverage/report.txt
            fi

            # Generate markdown coverage report using tix-to-markdown
            # Set locale to UTF-8 to support emoji characters
            echo "Generating markdown coverage report..."
            export LC_ALL=C.UTF-8
            ${tixToMarkdown}/bin/tix-to-markdown --hpcdir "$mix_dir" "$tix_file" > coverage/coverage.md 2>&1 || echo "Note: Could not generate markdown report"

            if [ -f coverage/coverage.md ] && [ -s coverage/coverage.md ]; then
              echo "Markdown coverage report generated successfully!"
              echo "---"
              cat coverage/coverage.md
              echo "---"
            fi
          else
            echo "Warning: Could not find .tix file or .mix directory"
            echo "  .tix file: $tix_file (exists: $([ -f "$tix_file" ] && echo "yes" || echo "no"))"
            echo "  .mix dir: $mix_dir (exists: $([ -d "$mix_dir" ] && echo "yes" || echo "no"))"
          fi
    '';

    installPhase = ''
          mkdir -p $out/share/hpc
          mkdir -p $out/bin

          # Copy coverage data
          cp -r coverage/html $out/share/hpc/
          [ -f coverage/report.txt ] && cp coverage/report.txt $out/share/hpc/ || true
          [ -f coverage/coverage.md ] && cp coverage/coverage.md $out/share/hpc/ || true
          [ -d coverage/tix ] && cp -r coverage/tix $out/share/hpc/ || true

          # Create a convenience script to view the report
          cat > $out/bin/view-coverage <<EOF
      #!/usr/bin/env bash
      set -e

      report_path="$out/share/hpc/html/index.html"

      if [ ! -f "\$report_path" ]; then
        echo "Error: Coverage report not found at \$report_path"
        exit 1
      fi

      echo "Opening coverage report..."
      echo "Report location: \$report_path"

      # Try to open in browser (works on macOS and most Linux)
      if command -v open >/dev/null 2>&1; then
        open "\$report_path"
      elif command -v xdg-open >/dev/null 2>&1; then
        xdg-open "\$report_path"
      else
        echo "Please open the following file in your browser:"
        echo "\$report_path"
      fi
      EOF
          chmod +x $out/bin/view-coverage

          # Create a script to show the text report
          cat > $out/bin/show-coverage-report <<EOF
      #!/usr/bin/env bash
      if [ -f "$out/share/hpc/report.txt" ]; then
        cat "$out/share/hpc/report.txt"
      else
        echo "No coverage report found."
      fi
      EOF
          chmod +x $out/bin/show-coverage-report

          echo "Coverage report installed to $out/share/hpc/html/index.html"
    '';

    meta = with pkgs.lib; {
      description = "Code coverage report for temporal-sdk Haskell packages";
      platforms = platforms.unix;
    };
  }
