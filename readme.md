# sweetbonanzarain app

## design

[figma](https://www.figma.com/file/vvY469gPjcqoG0vKuM8y0s/Sweet-Bonanza-Rain?type=design&node-id=0-1&mode=design&t=z51l81YXrEDYY3NT-0)
[assets]()

## links
- Game site: [sweetbonanzarain.com](https://sweetbonanzarain.com)
- [repo for static assets](https://github.com/NodeArt/sweetbonanzarain.com/tree/main/static/assets)
- [firebase project](https://console.firebase.google.com/project/sweetbonanzarain-com/overview)

## description

### env:

```Shell
BUNDLE_ID=com.sweetbonanzarain.app
APPSFLYER_DEV_KEY=YnVctVkaiKq3st3gsJe95Q
APPSFLYER_DEBUG=false
APPSFLYER_ONE_LINK=https://link.sweetbonanzarain.com/nRCi/uy8btw1t
DOMAIN_URL=https://sweetbonanzarain.com
SEND_ATTRIBUTION_POST=/api/attribution
SENTRY_DSN=
APPLE_ID_PREFIX=
```

## Metrics
- size of the resulting app
- amount of external requirements
- passing ios\android review
- app must build and operate on both Android and Ios

## Notes
### Game Engine
Please use [Flame](https://pub.dev/packages/flame) as engine
### Assets
There should be no assets in the resulting package. Please store all assets at CDN, and download them at loading screen when the app launched.
### Linter
Please use [flutter_lints](https://pub.dev/packages/flutter_lints) set of rules
### ATT request
Please add [app_tracking_transparency](https://pub.dev/packages/app_tracking_transparency), the request should be done on app start (even before loading)
### Push Messages
Please use [firebase_messaging](https://pub.dev/packages/firebase_messaging).
### Native splash
Please use [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) to provide loading screen to step BEFORE loading bar.
### Privacy page
Please use [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview) for webview. Url of privacy page to show: https://sweetbonanzarain.com/privacy
