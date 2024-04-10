import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smartpay_mobile/utils/helper.dart';
import 'package:smartpay_mobile/utils/theme_data.dart';

import 'screens/onboarding/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize app dependencies
  await initializeDependencies();

  await getIt.allReady();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartPay',
      debugShowCheckedModeBanner: false,
      theme: SmartPayThemeData.appThemeData(context),
      home: const SplashScreen(),
    );
  }
}
