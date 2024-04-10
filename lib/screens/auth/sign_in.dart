// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:smartpay_mobile/api/config.dart';
import 'package:smartpay_mobile/screens/auth/home.dart';
import 'package:smartpay_mobile/screens/auth/password_recovery.dart';
import 'package:smartpay_mobile/screens/auth/sign_up_screen.dart';
import 'package:smartpay_mobile/utils/app_colors.dart';
import 'package:smartpay_mobile/utils/app_widgets/main_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/app_widgets/text_button.dart';
import 'package:smartpay_mobile/utils/constants.dart';
import 'package:smartpay_mobile/utils/dimensions.dart';
import 'package:smartpay_mobile/utils/routes_navigator.dart';

import '../../providers/authetication_provider.dart';
import '../../utils/app_widgets/back_button.dart';
import '../../utils/app_widgets/text_field.dart';

class SignInScreen extends StatefulHookWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final signInFormKey = GlobalKey<FormState>();
  bool isFingerPrintUsable = false;

  void changeValue(WidgetRef ref, bool newValue) {
    ref.read(loginCheckingButtonProvider.notifier).update((state) => newValue);
  }

  @override
  initState() {
    initialAction();

    super.initState();
  }

  initialAction() async {
    String? passwordStored = await returnPassword();

    if (passwordStored != null) {
      setState(() {
        isFingerPrintUsable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final LocalAuthentication auth = LocalAuthentication();

    var emailController = useTextEditingController();
    var passwordController = useTextEditingController();
    var isPasswordVisible = useState(true);
    return Scaffold(
      backgroundColor: kWHTCOLOUR,
      body: SingleChildScrollView(
        child: Padded(
          child: Form(
            key: signInFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                yMargin(52),
                //  const SmartPayBackButton(isRouteAvailable: false),
                yMargin(26),
                Text(
                  'Hi There! 👋',
                  style: kTextStyleCustom(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
                yMargin(8),
                Text(
                  'Welcome back, Sign in to your account',
                  style: kTextStyleCustom(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: kLightGray),
                ),
                yMargin(32),
                SmartPayTextField(
                  controller: emailController,
                  hintText: 'Username',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    } else if (value.length < 3) {
                      return 'Please enter a valid Username';
                    }
                    return null;
                  },
                ),
                yMargin(16),
                SmartPayTextField(
                  controller: passwordController,
                  obscureText: isPasswordVisible.value,
                  hintText: 'Password',
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password is minimum of 6 characters';
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(getScreenHeight(12)),
                    child: InkWell(
                      onTap: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                      child: SvgPicture.asset(isPasswordVisible.value
                          ? 'assets/svgs/eye-off.svg'
                          : 'assets/svgs/eyevisible.svg'),
                    ),
                  ),
                ),
                yMargin(24),
                // SmartPayTextButton(
                //   onTap: () {
                //     RouteNavigators.route(
                //       context,
                //       const PasswordRecoveryScreen(),
                //     );
                //   },
                //   title: 'Forgot Password?',
                //   fontSize: 16,
                //   fontWeight: FontWeight.w700,
                //   color: kSECCOLOUR,
                // ),
                yMargin(24),
                Consumer(builder: (context, ref, child) {
                  final isItLoading = ref.watch(loginCheckingButtonProvider);
                  return !isItLoading
                      ? SmartPayMainButton(
                          text: 'Sign In',
                          onTap: () async {
                            if (signInFormKey.currentState!.validate()) {
                              changeValue(ref, true);
                              final action = await ref
                                  .read(emaillCheckingProvider.notifier)
                                  .login(emailController.value.text,
                                      passwordController.value.text);

                              if (action == true) {
                                writeUserEmail(emailController.value.text);
                                writeUserPassword(
                                    passwordController.value.text);

                                RouteNavigators.routeNoWayHome(
                                  context,
                                  const HomeScreen(),
                                );
                              }

                              changeValue(ref, false);
                            }
                          },
                        )
                      : const LoadingWidget();
                }),
                yMargin(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: getScreenWidth(142),
                      child: Divider(
                        color: kLIGHTINACTIVE,
                        thickness: getScreenHeight(0.5),
                      ),
                    ),
                    Text(
                      'OR',
                      style: kTextStyleCustom(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kLightGray),
                    ),
                    SizedBox(
                      width: getScreenWidth(142),
                      child: Divider(
                        color: kLIGHTINACTIVE,
                        thickness: getScreenHeight(0.7),
                      ),
                    ),
                  ],
                ),
                yMargin(10),
                Visibility(
                  visible: isFingerPrintUsable,
                  child: Consumer(builder: (context, ref, child) {
                    return Center(
                      child: InkWell(
                        onTap: () async {
                          // Future<void> _authenticateWithBiometrics() async {
                          bool authenticated = false;
                          try {
                            authenticated = await auth.authenticate(
                              localizedReason:
                                  'Scan your fingerprint (or face or whatever) to authenticate',
                              options: const AuthenticationOptions(
                                stickyAuth: true,
                                biometricOnly: true,
                              ),
                            );
                            String email = await returnEmail() ?? '';
                            String password = await returnPassword() ?? '';
                            if (authenticated == true) {
                              final action = await ref
                                  .read(emaillCheckingProvider.notifier)
                                  .login(email, password);

                              if (action == true) {
                                RouteNavigators.routeNoWayHome(
                                  context,
                                  const HomeScreen(),
                                );
                              }
                            }
                          } on PlatformException catch (e) {
                            print(e);

                            return;
                          }
                          if (!mounted) {
                            return;
                          }
                          // }
                        },
                        child: Icon(
                          Icons.fingerprint,
                          size: getScreenHeight(35),
                        ),
                      ),
                    );
                  }),
                ),
                yMargin(34),
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
                      'Don\'t have an account? ',
                      style: kTextStyleCustom(
                        fontSize: getScreenHeight(14),
                        fontWeight: FontWeight.w400,
                        color: kLightGray,
                      ),
                    ),
                    SmartPayTextButton(
                      onTap: () {
                        RouteNavigators.route(
                          context,
                          const SignUpScreen(),
                        );
                      },
                      title: 'Sign Up',
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
