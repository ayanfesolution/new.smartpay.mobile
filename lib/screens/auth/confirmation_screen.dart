import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smartpay_mobile/screens/auth/sign_in.dart';
import 'package:smartpay_mobile/utils/app_colors.dart';
import 'package:smartpay_mobile/utils/app_widgets/main_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/constants.dart';
import 'package:smartpay_mobile/utils/dimensions.dart';
import 'package:smartpay_mobile/utils/routes_navigator.dart';

class ConfirmCompleteScreen extends StatefulHookWidget {
  const ConfirmCompleteScreen({super.key});

  @override
  State<ConfirmCompleteScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWHTCOLOUR,
      body: Padded(
        child: Column(
          children: [
            yMargin(233),
            SizedBox(
              height: getScreenHeight(138),
              width: getScreenWidth(140),
              child: Image.asset('assets/images/confirmationfinish.png'),
            ),
            yMargin(32),
            Text(
              'Congratulations, James',
              style: kTextStyleCustom(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            yMargin(12),
            Text(
              'You’ve completed the onboarding, \nyou can start using',
              style: kTextStyleCustom(
                  fontWeight: FontWeight.w400, fontSize: 16, color: kLightGray),
              textAlign: TextAlign.center,
            ),
            yMargin(32),
            SmartPayMainButton(
                text: 'Get Started',
                onTap: () {
                  RouteNavigators.routeNoWayHome(
                    context,
                    const SignInScreen(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
