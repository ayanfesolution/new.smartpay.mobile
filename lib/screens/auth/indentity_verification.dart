import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartpay_mobile/screens/auth/reset_password.dart';
import 'package:smartpay_mobile/utils/app_colors.dart';

import '../../utils/app_widgets/main_button.dart';
import '../../utils/app_widgets/padded.dart';
import '../../utils/constants.dart';
import '../../utils/dimensions.dart';
import '../../utils/routes_navigator.dart';

class IndentityVerificationScreen extends StatefulHookWidget {
  const IndentityVerificationScreen({super.key});

  @override
  State<IndentityVerificationScreen> createState() =>
      _IndentityVerificationScreenState();
}

class _IndentityVerificationScreenState
    extends State<IndentityVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWHTCOLOUR,
      body: Padded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            yMargin(80),
            SvgPicture.asset('assets/svgs/indentity.svg'),
            yMargin(24),
            Text(
              'Verify your identity',
              style:
                  kTextStyleCustom(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            yMargin(12),
            Text.rich(
              TextSpan(text: 'Where would you like ', children: [
                TextSpan(
                  text: 'Smartpay',
                  style: kTextStyleCustom(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kSECCOLOUR,
                  ),
                ),
                TextSpan(
                  text: ' to send your security code?',
                  style: kTextStyleCustom(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: kLightGray,
                  ),
                )
              ]),
              style: kTextStyleCustom(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: kLightGray,
              ),
            ),

            yMargin(32),
            Container(
              height: getScreenHeight(88),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getScreenHeight(16),
                  ),
                  color: kTEXTFIELDBACKGROUND),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getScreenWidth(16)),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/check.svg'),
                    xMargin(18),
                    Text.rich(
                      TextSpan(
                        text: 'Email\n',
                        children: [
                          TextSpan(
                            text: 'A*******@mail.com',
                            style: kTextStyleCustom(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: kLightGray,
                            ),
                          ),
                        ],
                        style: kTextStyleCustom(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: kPRYCOLOUR,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset('assets/svgs/mail.svg')),
                    )
                  ],
                ),
              ),
            ),

            //yMargin(size)
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: getScreenHeight(50)),
                    child: SmartPayMainButton(
                      text: 'Send me email',
                      onTap: () {
                        RouteNavigators.route(
                          context,
                          const ResetPasswordScreen(),
                        );
                      },
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
