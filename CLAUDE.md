# CLAUDE.md

The glaze-os.com website and App Store publishing for Glaze (the Casio BE-300
OS in the sibling `../glaze-os` repo). See README.md.

- The website is static HTML in `site/`. `tools/mksite.py` builds its images from emulator
  screenshots taken with glaze-os's `tests/run.sh` (its header lists the runs).
  `tools/publish_site.py` publishes it to the `glaze-os-site` stack (`infra/site/stack.json`).
  See `docs/WEBSITE.md`.
- `site/` is published as is. Never put notes, Markdown or anything private in it;
  `publish_site.py` refuses Markdown there.
- The App Store: `make store` runs glaze-os's `tools/mkstore.py` over the built packages of
  glaze-os, glaze-apps and glaze-emulators, using `store/apps.json` for listings.
  `tools/publish_appstore.py` uploads immutable assets first and the catalog last
  (`infra/appstore/stack.json`, `docs/APP_STORE_AWS.md`). A changed package needs a
  version bump before it can be published again.
- Release downloads (GlazeBoot ZIPs, installers) are built in glaze-os and the installer
  repo. Only their metadata and checksums are tracked in `site/downloads`.
- Tests: `make test` (offline). Publishing needs AWS credentials and is outward-facing,
  so run `--dry-run` first and publish only when asked.
- Never commit AWS credentials or release binaries.
