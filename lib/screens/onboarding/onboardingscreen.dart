import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smartpay_mobile/utils/app_colors.dart';
import 'package:smartpay_mobile/utils/app_widgets/main_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/app_widgets/text_button.dart';
import 'package:smartpay_mobile/utils/dimensions.dart';
import 'package:smartpay_mobile/utils/routes_navigator.dart';

import '../../utils/constants.dart';
import '../auth/sign_in.dart';
import 'onboarding_widgets.dart';
import 'onboardingmodel.dart';

class OnboardingScreen extends StatefulHookWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardingModel> onboardingDataList = [
    OnboardingModel(
      'Finance app the safest and most trusted',
      'Your finance work starts here. Our here to help you track and deal with speeding up your transactions.',
      'assets/images/deviceone.png',
      'assets/images/illustrationone.png',
      '1',
    ),
    OnboardingModel(
      'The fastest transaction process only here',
      'Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.',
      'assets/images/devicetwo.png',
      'assets/images/illustrationtwo.png',
      '2',
    )
  ];
  @override
  Widget build(BuildContext context) {
    var currentIndex = useState(0);
    var pageController = usePageController();
    return Scaffold(
      body: Column(
        children: [
          yMargin(68),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: getScreenWidth(24)),
                child: SmartPayTextButton(
                  onTap: () {
                    if (pageController.page != 1) {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.bounceIn);
                    } else {
                      RouteNavigators.routeNoWayHome(
                          context, const SignInScreen());
                    }
                  },
                  title: 'Skip',
                  color: kSECCOLOUR,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )),
          Expanded(
            child: PageView.builder(
              onPageChanged: (data) {
                currentIndex.value = data;
              },
              controller: pageController,
              itemCount: onboardingDataList.length,
              itemBuilder: (context, index) {
                OnboardingModel dataToUse = onboardingDataList[index];
                return OnboardingWidgets(
                    imagePathOne: dataToUse.imagePathOne,
                    imagePathTwo: dataToUse.imagePathTwo,
                    subTitle: dataToUse.subTitle,
                    title: dataToUse.title,
                    index: dataToUse.index);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: getScreenHeight(58),
                left: getScreenWidth(44),
                right: getScreenWidth(44),
              ),
              child: SmartPayMainButton(
                onTap: () {
                  RouteNavigators.routeNoWayHome(context, const SignInScreen());
                },
                text: 'Get Started',
              ),
            ),
          )
        ],
      ),
    );
  }
}
