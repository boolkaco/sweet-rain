import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/screens/loading_screen.dart';
import 'package:sweetbonanzarain/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        BlocProvider<AppCubit>(create: (context) => AppCubit()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return Builder(
            builder: (context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: MaterialApp(
                  title: 'bonanzo',
                  theme: themeNotifier.currentTheme,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  home: const LoadingScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
