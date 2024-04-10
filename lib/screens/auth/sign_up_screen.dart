import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smartpay_mobile/screens/auth/otp_verification_screen.dart';
import 'package:smartpay_mobile/screens/auth/sign_in.dart';
import 'package:smartpay_mobile/utils/app_colors.dart';
import 'package:smartpay_mobile/utils/app_widgets/back_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/app_widgets/text_field.dart';
import 'package:smartpay_mobile/utils/constants.dart';

import '../../providers/authetication_provider.dart';
import '../../utils/app_widgets/main_button.dart';
import '../../utils/app_widgets/text_button.dart';
import '../../utils/dimensions.dart';
import '../../utils/routes_navigator.dart';
import 'profile_setup_screen.dart';

class SignUpScreen extends StatefulHookWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpEmailFormKey = GlobalKey<FormState>();

  void changeValue(WidgetRef ref, bool newValue) {
    ref.read(emaillCheckingButtonProvider.notifier).update((state) => newValue);
  }

  @override
  Widget build(BuildContext context) {
    var emailTextController = useTextEditingController();
    var username = useTextEditingController();
    var isActive = useState(false);
    var isPasswordVisible = useState(true);
    var password = useTextEditingController();

    return Scaffold(
      backgroundColor: kWHTCOLOUR,
      body: SingleChildScrollView(
        child: Padded(
          child: Form(
            key: signUpEmailFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                yMargin(52),
                const SmartPayBackButton(),
                yMargin(30),
                Text.rich(
                  TextSpan(
                    text: 'Create a ',
                    children: [
                      TextSpan(
                        text: 'Smartpay\n',
                        style: kTextStyleCustom(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: kSECCOLOUR,
                        ),
                      ),
                      const TextSpan(text: 'account')
                    ],
                    style: kTextStyleCustom(
                        fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                yMargin(32),
                SmartPayTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  onChange: (value) {
                    if (value.isNotEmpty &&
                        username.value.text.isNotEmpty &&
                        password.value.text.isNotEmpty) {
                      isActive.value = true;
                    } else {
                      isActive.value = false;
                    }
                  },
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
                yMargin(24),
                SmartPayTextField(
                  controller: username,
                  hintText: 'Username',
                  onChange: (value) {
                    if (value.isNotEmpty &&
                        emailTextController.value.text.isNotEmpty &&
                        password.value.text.isNotEmpty) {
                      isActive.value = true;
                    } else {
                      isActive.value = false;
                    }
                  },
                ),
                yMargin(24),
                SmartPayTextField(
                  controller: password,
                  obscureText: isPasswordVisible.value,
                  hintText: 'Password',
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password is minimum of 6 characters';
                    } else {
                      return null;
                    }
                  },
                  onChange: (value) {
                    if (value.isNotEmpty &&
                        emailTextController.value.text.isNotEmpty &&
                        username.value.text.isNotEmpty) {
                      isActive.value = true;
                    } else {
                      isActive.value = false;
                    }
                  },
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(getScreenHeight(12)),
                    child: InkWell(
                      onTap: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                      child: SvgPicture.asset(
                        isPasswordVisible.value
                            ? 'assets/svgs/eye-off.svg'
                            : 'assets/svgs/eyevisible.svg',
                      ),
                    ),
                  ),
                ),

                yMargin(24),
                SmartPayMainButton(
                  text: 'Next',
                  backgroundColor:
                      isActive.value ? kBLKCOLOUR : kBLKCOLOUR.withOpacity(0.7),
                  onTap: () async {
                    if (signUpEmailFormKey.currentState!.validate() &
                            isActive.value ==
                        true) {
                      RouteNavigators.route(
                        context,
                        ProfileSetUpScreen(
                          email: emailTextController.value.text,
                          password: password.text,
                          username: username.text,
                        ),
                      );
                    }
                  },
                ),

                yMargin(32),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     SizedBox(
                //       width: getScreenWidth(142),
                //       child: Divider(
                //         color: kLIGHTINACTIVE,
                //         thickness: getScreenHeight(0.5),
                //       ),
                //     ),
                //     Text(
                //       'OR',
                //       style: kTextStyleCustom(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //           color: kLightGray),
                //     ),
                //     SizedBox(
                //       width: getScreenWidth(142),
                //       child: Divider(
                //         color: kLIGHTINACTIVE,
                //         thickness: getScreenHeight(0.7),
                //       ),
                //     ),
                //   ],
                // ),
                // // yMargin(34),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     InkWell(
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(
                //             getScreenHeight(16),
                //           ),
                //           border: Border.all(style: BorderStyle.solid),
                //         ),
                //         height: getScreenHeight(56),
                //         width: getScreenWidth(155),
                //         child: Image.asset('assets/images/google.png'),
                //       ),
                //     ),
                //     InkWell(
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(
                //             getScreenHeight(16),
                //           ),
                //           border: Border.all(style: BorderStyle.solid),
                //         ),
                //         height: getScreenHeight(56),
                //         width: getScreenWidth(155),
                //         child: Image.asset('assets/images/apple.png'),
                //       ),
                //     ),
                //   ],
                // ),
                // yMargin(117),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: kTextStyleCustom(
                        fontSize: getScreenHeight(14),
                        fontWeight: FontWeight.w400,
                        color: kLightGray,
                      ),
                    ),
                    SmartPayTextButton(
                      onTap: () {
                        RouteNavigators.routeNoWayHome(
                          context,
                          const SignInScreen(),
                        );
                      },
                      title: 'Sign In',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: kSECCOLOUR,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: getScreenHeight(30),
        width: getScreenWidth(30),
        child: const CircularProgressIndicator.adaptive(
          backgroundColor: kPRYCOLOUR,
        ),
      ),
    );
  }
}
