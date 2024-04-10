import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smartpay_mobile/screens/auth/home.dart';
import 'package:smartpay_mobile/screens/auth/sign_in.dart';
import 'package:smartpay_mobile/utils/app_colors.dart';
import 'package:smartpay_mobile/utils/app_widgets/back_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/main_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/app_widgets/text_field.dart';
import 'package:smartpay_mobile/utils/constants.dart';
import 'package:smartpay_mobile/utils/dimensions.dart';
import 'package:smartpay_mobile/utils/routes_navigator.dart';

class ResetPasswordScreen extends StatefulHookWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final confirmPasswordKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var newPasswordController = useTextEditingController();
    var confirmPasswordController = useTextEditingController();
    return Scaffold(
      backgroundColor: kWHTCOLOUR,
      body: Padded(
        child: Form(
          key: confirmPasswordKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              yMargin(52),
              const SmartPayBackButton(),
              yMargin(32),
              Text(
                'Create New Password',
                style:
                    kTextStyleCustom(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              yMargin(12),
              Text(
                'Please, enter a new password below different from the previous password',
                style: kTextStyleCustom(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kLightGray,
                ),
              ),
              yMargin(32),
              SmartPayTextField(
                controller: newPasswordController,
                obscureText: true,
                hintText: 'New Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Password cannot be empty');
                  } else if (value.length < 6) {
                    return 'Password must be minimum of 6 characters';
                  }
                  return null;
                },
              ),
              yMargin(16),
              SmartPayTextField(
                controller: confirmPasswordController,
                obscureText: true,
                hintText: 'Confirm Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Minimum of 6 characters');
                  } else if (newPasswordController.value.text != value) {
                    return 'Password not match';
                  }
                  return null;
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: getScreenHeight(50)),
                    child: SmartPayMainButton(
                      text: 'Create new password',
                      onTap: () {
                        if (confirmPasswordKey.currentState!.validate()) {
                          RouteNavigators.routeNoWayHome(
                              context, const SignInScreen());
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
