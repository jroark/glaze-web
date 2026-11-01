# glaze-web

The [glaze-os.com](https://glaze-os.com) website and the Glaze App Store's
publishing, for [Glaze](https://github.com/jroark/glaze-os), the microkernel OS
for the Casio BE-300.

| Path | What |
| --- | --- |
| `site/` | The static website, published to S3 and CloudFront |
| `infra/site/`, `infra/appstore/` | CloudFormation stacks for the site and `appstore.glaze-os.com` |
| `store/apps.json` | The App Store's listing metadata (one record per app) |
| `tools/mksite.py` | Builds `site/img` from emulator screenshots |
| `tools/publish_site.py`, `tools/publish_appstore.py` | Verified publishing (AWS CLI v2) |
| `docs/` | [Website](docs/WEBSITE.md) and [App Store on AWS](docs/APP_STORE_AWS.md) guides |

## Sibling checkouts

Everything published is built in sibling checkouts, which this repo reads by
default from `../glaze-os`, `../glaze-apps` and `../glaze-emulators`
(`GLAZE_DIR`, `APPS_DIR`, `EMU_DIR`):

- glaze-os builds the OS images and GlazeBoot releases (its `tools/package_glazeboot.py
  --site-dir ../glaze-web/site` writes `site/downloads`) and runs the screenshot scripts.
- Each repo's `./build.sh` builds its packages into its `out/pkg`.
- glaze-os's `tools/mkstore.py` writes the catalog format the device's App Store reads.

## Commands

```sh
make store                                          # out/store from all three repos' packages
make test                                           # offline release and publisher checks
python3 tools/publish_appstore.py --dry-run         # then --profile <aws profile>
python3 tools/publish_site.py --profile <aws profile> --dry-run
```

`site/` holds only what is published: keep notes such as this README outside it.
`publish_site.py` refuses Markdown files there.
