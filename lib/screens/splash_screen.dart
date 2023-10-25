import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../controllers/splash_screen_controller.dart';
import '../generated/assets.dart';
import '../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    offset = Tween(begin: Offset.zero, end: const Offset(0.0, .35))
        .animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Get.put(SplashScreenController());
    return Material(
      child: Container(
        height: size.height,
        width: size.width,
        color: AppColors.secondaryBlueColor,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SlideTransition(
                position: offset,
                child:
                
                SvgPicture.asset(Assets.svgHappyGhost),
            ),
            const SizedBox(
              height: 50,
            ),
            ScalingText(
              'party wizard',
              style: const TextStyle(
                  fontFamily: 'nickainley',
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "your party supplier",
              style: GoogleFonts.quicksand(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
