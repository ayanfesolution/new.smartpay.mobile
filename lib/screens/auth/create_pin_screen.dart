import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smartpay_mobile/screens/auth/confirmation_screen.dart';
import 'package:smartpay_mobile/utils/app_colors.dart';
import 'package:smartpay_mobile/utils/app_widgets/back_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/main_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/constants.dart';
import 'package:smartpay_mobile/utils/dimensions.dart';

import '../../utils/app_widgets/pincode_textfield_widget.dart';
import '../../utils/routes_navigator.dart';

class CreatePinScreen extends StatefulHookWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final pinFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var isActive = useState(false);
    var pinTextController = useTextEditingController();

    return Scaffold(
      backgroundColor: kWHTCOLOUR,
      body: Padded(
        child: Form(
          key: pinFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              yMargin(52),
              const SmartPayBackButton(),
              yMargin(32),
              Text(
                'Set your PIN code',
                style:
                    kTextStyleCustom(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              yMargin(12),
              Text(
                'We use state-of-the-art security measures to protect your information at all times',
                style: kTextStyleCustom(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: kLightGray),
              ),
              yMargin(30),
              PinUnderlineVerificationField(
                emailVerificationPasswordFormKey: pinFormKey,
                emailVerifyPinController: pinTextController,
                onChanged: (value) {
                  if (value.length == 5) {
                    isActive.value = true;
                  }
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: getScreenHeight(60)),
                    child: SmartPayMainButton(
                      text: 'Create PIN',
                      backgroundColor: isActive.value
                          ? kBLKCOLOUR
                          : kBLKCOLOUR.withOpacity(0.7),
                      onTap: () {
                        if (pinTextController.value.text.length == 5 &&
                            isActive.value == true) {
                          RouteNavigators.route(
                            context,
                            const ConfirmCompleteScreen(),
                          );
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
