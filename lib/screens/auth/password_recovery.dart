import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartpay_mobile/screens/auth/indentity_verification.dart';
import 'package:smartpay_mobile/utils/app_colors.dart';
import 'package:smartpay_mobile/utils/app_widgets/main_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/app_widgets/text_field.dart';
import 'package:smartpay_mobile/utils/constants.dart';
import 'package:smartpay_mobile/utils/dimensions.dart';
import 'package:smartpay_mobile/utils/routes_navigator.dart';

class PasswordRecoveryScreen extends StatefulHookWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final passwordRecoveryFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = useTextEditingController();
    return Scaffold(
      backgroundColor: kWHTCOLOUR,
      body: Padded(
        child: Form(
          key: passwordRecoveryFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              yMargin(80),
              SvgPicture.asset('assets/svgs/lock.svg'),
              yMargin(24),
              Text(
                'Passsword Recovery',
                style:
                    kTextStyleCustom(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              yMargin(12),
              Text(
                'Enter your registered email below to receive password instructions',
                style: kTextStyleCustom(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kLightGray,
                ),
              ),
              yMargin(32),
              SmartPayTextField(
                controller: emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
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
                          if (passwordRecoveryFormKey.currentState!
                              .validate()) {
                            RouteNavigators.route(
                              context,
                              const IndentityVerificationScreen(),
                            );
                          }
                        },
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
