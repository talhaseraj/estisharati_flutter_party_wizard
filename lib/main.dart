import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_wizard/constants/theme.dart';
import 'package:party_wizard/screens/splash_screen.dart';
import 'package:party_wizard/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:party_wizard/utils/localizations/translation.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      translations: Translation(),
      fallbackLocale: const Locale("en"),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.poppins(),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
        useMaterial3: true,
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: AppColors.primaryColor),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: CustomTheme.borderRadius,
            borderSide: const BorderSide(color: AppColors.c_c4c4c4),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: CustomTheme.borderRadius,
            borderSide: const BorderSide(color: AppColors.c_c4c4c4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: CustomTheme.borderRadius,
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
