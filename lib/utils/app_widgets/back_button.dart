import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartpay_mobile/screens/auth/home.dart';

import '../app_colors.dart';
import '../dimensions.dart';
import '../routes_navigator.dart';

class SmartPayBackButton extends StatelessWidget {
  const SmartPayBackButton({super.key, this.isRouteAvaliable = true});
  final bool isRouteAvaliable;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isRouteAvaliable == true) RouteNavigators.pop(context);
      },
      child: Container(
        height: getScreenHeight(40),
        width: getScreenWidth(40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getScreenHeight(12)),
            border: Border.all(color: kBorderLineColor)),
        child: Padding(
          padding: EdgeInsets.all(getScreenHeight(12)),
          child: SizedBox(
            child: SvgPicture.asset(
              'assets/svgs/backbutton.svg',
              height: getScreenHeight(24),
              width: getScreenWidth(24),
            ),
          ),
        ),
      ),
    );
  }
}
