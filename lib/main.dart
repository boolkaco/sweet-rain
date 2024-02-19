// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sweetbonanzarain/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/utils/image_loader.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sweetbonanzarain/services/logger.dart';

Future<void> main() async {
  await platformInit();

  await SentryFlutter.init(
    _sentryOptions,
    appRunner: () => runApp(const EntryPoint()),
  );
  runApp(const EntryPoint());
}

Future<void> platformInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await dotenv.load(fileName: ".env");
  log = MultipleLibrariesLogging();
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    Hive.initFlutter(),
  ]);
}

void _sentryOptions(SentryFlutterOptions options) {
  options.dsn = dotenv.env['SENTRY_DSN'];
  options.tracesSampleRate = 1.0;
  options.sendDefaultPii = true;
  options.attachScreenshot = false;
  options.attachStacktrace = true;
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: Provider<AudioService>(
        create: (_) => AudioService(),
        child: const App(),
      ),
    );
  }
}
