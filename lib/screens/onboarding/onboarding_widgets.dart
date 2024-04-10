import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimensions.dart';

class OnboardingWidgets extends StatelessWidget {
  const OnboardingWidgets({
    super.key,
    required this.title,
    required this.subTitle,
    required this.index,
    required this.imagePathOne,
    required this.imagePathTwo,
  });
  final String title, subTitle, imagePathOne, imagePathTwo, index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                top: getScreenHeight(86),
                bottom: getScreenHeight(118),
                left: getScreenWidth(45),
                right: getScreenWidth(45),
              ),
              child: Image.asset(imagePathOne),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: getScreenHeight(122),
              bottom: getScreenHeight(243),
              left: getScreenWidth(45),
              right: getScreenWidth(45),
            ),
            child: Image.asset(imagePathTwo),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(color: kWHTCOLOUR, boxShadow: [
                BoxShadow(
                  color: kWHTCOLOUR.withOpacity(0.5),
                  blurRadius: getScreenHeight(5),
                  blurStyle: BlurStyle.solid,
                  spreadRadius: getScreenHeight(30),
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: kWHTCOLOUR.withOpacity(0.6),
                  blurRadius: getScreenHeight(5),
                  blurStyle: BlurStyle.solid,
                  spreadRadius: getScreenHeight(30),
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: kWHTCOLOUR.withOpacity(0.7),
                  blurRadius: getScreenHeight(5),
                  blurStyle: BlurStyle.solid,
                  spreadRadius: getScreenHeight(30),
                  offset: const Offset(0, 0),
                ),
              ]),
              height: getScreenHeight(243),
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getScreenWidth(44)),
                child: Column(
                  children: [
                    yMargin(46),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: kTextStyleCustom(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    yMargin(16),
                    Text(
                      subTitle,
                      textAlign: TextAlign.center,
                      style: kTextStyleCustom(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: kLightGray,
                      ),
                    ),
                    yMargin(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: getScreenHeight(6),
                          width: index == '1'
                              ? getScreenWidth(32)
                              : getScreenWidth(6),
                          decoration: BoxDecoration(
                            color: index == '1' ? kPRYCOLOUR : kLIGHTINACTIVE,
                            borderRadius: BorderRadius.circular(
                              getScreenHeight(3),
                            ),
                          ),
                        ),
                        xMargin(4),
                        Container(
                          height: getScreenHeight(6),
                          width: index == '1'
                              ? getScreenWidth(6)
                              : getScreenWidth(32),
                          decoration: BoxDecoration(
                            color: index == '1' ? kLIGHTINACTIVE : kPRYCOLOUR,
                            borderRadius: BorderRadius.circular(
                              getScreenHeight(3),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
