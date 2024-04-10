import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../app_colors.dart';

class PinVerificationField extends StatelessWidget {
  const PinVerificationField({
    super.key,
    required this.emailVerifyPinController,
    required this.emailVerificationPasswordFormKey,
    this.onChanged,
    this.isBox = true,
  });

  final TextEditingController emailVerifyPinController;
  final GlobalKey<FormState> emailVerificationPasswordFormKey;
  final Function(String)? onChanged;
  final bool isBox;

  @override
  Widget build(BuildContext context) {
    return PinInputTextFormField(
      pinLength: 5,
      decoration: BoxLooseDecoration(
        strokeColorBuilder: PinListenColorBuilder(kTransperent, kSECCOLOUR),
        bgColorBuilder:
            PinListenColorBuilder(kTEXTFIELDBACKGROUND, kTEXTFIELDBACKGROUND),
      ),
      enabled: true,
      keyboardType: TextInputType.number,
      controller: emailVerifyPinController,
      onSubmit: (pin) {
        if (emailVerificationPasswordFormKey.currentState!.validate()) {
          emailVerificationPasswordFormKey.currentState!.save();
        }
      },
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Verification code is empty';
        } else if (value.length != 5) {
          return 'Code not complete, Check again';
        } else {
          return null;
        }
      },
      cursor: Cursor(
        width: 2,
        color: kPRYCOLOUR,
        //radius: Radius.circular(1),
        enabled: true,
      ),
    );
  }
}

class PinUnderlineVerificationField extends StatelessWidget {
  const PinUnderlineVerificationField({
    super.key,
    required this.emailVerifyPinController,
    required this.emailVerificationPasswordFormKey,
    this.onChanged,
    this.isBox = true,
  });

  final TextEditingController emailVerifyPinController;
  final GlobalKey<FormState> emailVerificationPasswordFormKey;
  final Function(String)? onChanged;
  final bool isBox;

  @override
  Widget build(BuildContext context) {
    return PinInputTextFormField(
      pinLength: 5,
      decoration: UnderlineDecoration(
        colorBuilder: PinListenColorBuilder(kSECCOLOUR, kSECCOLOUR),
      ),
      enabled: true,
      keyboardType: TextInputType.number,
      controller: emailVerifyPinController,
      onSubmit: (pin) {
        if (emailVerificationPasswordFormKey.currentState!.validate()) {
          emailVerificationPasswordFormKey.currentState!.save();
        }
      },
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Verification code is empty';
        } else if (value.length != 5) {
          return 'Code not complete, Check again';
        } else {
          return null;
        }
      },
      cursor: Cursor(
        width: 2,
        color: kSECCOLOUR,
        enabled: true,
      ),
    );
  }
}
