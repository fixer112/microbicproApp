import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microbicpro/pages/splashscreen.dart';
import 'package:microbicpro/values.dart';
import 'package:provider/provider.dart';

import 'provider/main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MainModel>(
          create: (_) => MainModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: primaryColor.withValues(alpha: 0.3),
        selectionHandleColor: primaryColor,
      ),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return GetMaterialApp(
      title: 'MicrobicPro',
      theme: theme,
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
