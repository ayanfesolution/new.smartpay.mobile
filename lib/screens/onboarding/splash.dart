// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smartpay_mobile/screens/auth/home.dart';
import 'package:smartpay_mobile/screens/auth/sign_in.dart';
import 'package:smartpay_mobile/utils/helper.dart';

import '../../api/config.dart';
import '../../utils/dimensions.dart';
import '../../utils/routes_navigator.dart';
import 'onboardingscreen.dart';

class SplashScreen extends StatefulHookWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String id = 'splash.screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    initialAction();
    super.initState();
  }

  void screeenToDisplay() async {
    bool result = await checkIfIsFirstLaunch();

    if (result == false) {
      RouteNavigators.routeReplace(
        context,
        const OnboardingScreen(),
      );
    } else {
      RouteNavigators.routeReplace(
        context,
        const HomeScreen(),
      );
    }
  }

  Future<Timer> initialAction() async {
    return Timer(
      const Duration(seconds: 3),
      () {
        screeenToDisplay();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AnimationController controller = useAnimationController(
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    late final Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack,
    );
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: getScreenHeight(150),
          width: getScreenWidth(150),
          child: ScaleTransition(
            scale: animation,
            child: Image.asset(
              'assets/images/logo.png',
              height: getScreenHeight(200),
              width: getScreenWidth(200),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
