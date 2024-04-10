// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smartpay_mobile/screens/auth/profile_setup_screen.dart';
import 'package:smartpay_mobile/screens/auth/sign_up_screen.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/app_widgets/text_button.dart';
import 'package:smartpay_mobile/utils/dimensions.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../providers/authetication_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_widgets/back_button.dart';
import '../../utils/app_widgets/main_button.dart';
import '../../utils/app_widgets/pincode_textfield_widget.dart';
import '../../utils/constants.dart';
import '../../utils/routes_navigator.dart';

class OtpVerificationScreen extends StatefulHookWidget {
  const OtpVerificationScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final verifyFormKey = GlobalKey<FormState>();
  void changeValue(WidgetRef ref, bool newValue) {
    ref
        .read(verifyEmaillCheckingButtonProvider.notifier)
        .update((state) => newValue);
  }

  @override
  Widget build(BuildContext context) {
    var verifyTextController = useTextEditingController();
    var isResendEnabled = useState(false);
    var isActive = useState(false);
    return Scaffold(
      backgroundColor: kWHTCOLOUR,
      body: Padded(
        child: Form(
          key: verifyFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              yMargin(52),
              const SmartPayBackButton(),
              yMargin(32),
              Text(
                'Verify it’s you',
                style:
                    kTextStyleCustom(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              yMargin(12),
              Text.rich(
                TextSpan(
                  text: 'We send a code to ( ',
                  children: [
                    TextSpan(
                      text: widget.email,
                      style: kTextStyleCustom(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kPRYCOLOUR,
                      ),
                    ),
                    const TextSpan(
                        text: '). Enter it here to verify your identity'),
                  ],
                  style: kTextStyleCustom(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: kLightGray,
                  ),
                ),
              ),
              yMargin(32),
              PinVerificationField(
                emailVerificationPasswordFormKey: verifyFormKey,
                emailVerifyPinController: verifyTextController,
                onChanged: (value) {
                  if (value.length == 5) {
                    isActive.value = true;
                  }
                },
              ),
              yMargin(32),
              isResendEnabled.value
                  ? Consumer(builder: (context, ref, child) {
                      return Center(
                        child: SmartPayTextButton(
                          onTap: () {
                            isResendEnabled.value = false;
                            ref
                                .read(emaillCheckingProvider.notifier)
                                .getEmailToken(widget.email);
                          },
                          title: 'Resend OTP',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: kLightButton,
                        ),
                      );
                    })
                  : Center(
                      child: Countdown(
                        seconds: 30,
                        build: (BuildContext context, double time) => Text(
                          'Resend Code ${time.toInt()} secs',
                          style: kTextStyleCustom(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: kLightButton,
                          ),
                        ),
                        interval: const Duration(seconds: 1),
                        onFinished: () {
                          isResendEnabled.value = true;
                        },
                      ),
                    ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: getScreenHeight(70)),
                    child: Consumer(builder: (context, ref, child) {
                      final isItLoading =
                          ref.watch(verifyEmaillCheckingButtonProvider);
                      return !isItLoading
                          ? SmartPayMainButton(
                              text: 'Confirm',
                              backgroundColor: isActive.value
                                  ? kBLKCOLOUR
                                  : kBLKCOLOUR.withOpacity(0.7),
                              onTap: () async {
                                if (verifyTextController.value.text.length ==
                                        5 &&
                                    isActive.value == true) {
                                  changeValue(ref, true);
                                  //The api response was giving error 422, a database error, so to make it flow without the call.
                                  // RouteNavigators.route(
                                  //   context,
                                  //   ProfileSetUpScreen(
                                  //     email: widget.email,
                                  //   ),
                                  // );
                                  final action = await ref
                                      .read(emaillCheckingProvider.notifier)
                                      .verifyEmailToken(widget.email,
                                          verifyTextController.value.text);

                                  if (action == true) {
                                    // RouteNavigators.route(
                                    //   context,
                                    //   ProfileSetUpScreen(
                                    //     email: widget.email,
                                    //   ),
                                    // );
                                  }

                                  changeValue(ref, false);
                                }
                              },
                            )
                          : const LoadingWidget();
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
