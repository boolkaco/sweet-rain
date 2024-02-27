// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/utils/layout_wrapper.dart';
import 'package:sweetbonanzarain/widgets/back_button.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class PrivacyScreen extends StatelessWidget {
  PrivacyScreen({super.key});

  final PlatformWebViewController controller = PlatformWebViewController(
    WebKitWebViewControllerCreationParams(
      allowsInlineMediaPlayback: true,
    ),
  )
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent);

  @override
  Widget build(BuildContext context) {
    String privacyUrl = '${dotenv.env['DOMAIN_URL']}/privacy';
    controller.loadRequest(LoadRequestParams(uri: Uri.parse(privacyUrl)));
    Size size = MediaQuery.of(context).size;

    return BackgroundWrapper(
      isShownLogo: false,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 60,
          right: 47,
          left: 47,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.file(
                  ImagesService().getByFilename(assetsMap['privacy_bg']!)!,
                  width: size.width * 0.6,
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 32,
                      top: 32,
                      right: 25,
                      left: 25,
                    ),
                    child: PlatformWebViewWidget(
                      PlatformWebViewWidgetCreationParams(
                        controller: controller,
                      ),
                    ).build(context),
                  ),
                )
              ],
            ),
            Expanded(child: Container()),
            const SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppBackButton(),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}
