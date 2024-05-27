name: CPack

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build_packages_Linux:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v2
        with:
          node-version: '20'
      - name: Config 
        run: cmake ${{github.workspace}} -B ${{github.workspace}}/build -D PRINT_VERSION=1.0.0

      - name: Build 
        run: cmake --build ${{github.workspace}}/build

      - name: Build 
        run: cmake --build ${{github.workspace}}/build --target package

      - name: Build 
        run: cmake --build ${{github.workspace}}/build --target package_source

      - name: Make a release
        uses: ncipollo/release-action@v1.11.0
        with:
          tag: v1.0.0
          artifacts: "build/*.deb,build/*.tar.gz,build/*.zip"
          token: ${{ secrets.GITHUB_TOKEN }}
      - name: Artifacts
        uses: actions/upload-artifact@v4
        with:
          name: example
          path: build/example
      - name: Build example
    run: cmake --build ${{github.workspace}}/build