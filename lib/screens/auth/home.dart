import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpay_mobile/providers/authetication_provider.dart';
import 'package:smartpay_mobile/screens/auth/sign_in.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/constants.dart';
import 'package:smartpay_mobile/utils/dimensions.dart';
import 'package:smartpay_mobile/utils/helper.dart';
import 'package:smartpay_mobile/utils/routes_navigator.dart';

import '../../model/profile_detail_model.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initialCall();
    initialAction();
  }

  initialCall() async {
    await ref.read(profileProvider.notifier).dashboard();
    var date = await FlutterSessionJwt.getDurationFromIssuedTime();
    if (kDebugMode) {
      print(date);
    }
  }

  initialAction() async {
    bool result = await FlutterSessionJwt.isTokenExpired();
    print('Is token expired is $result');
    if (result) {
      kToastMsgPopUp('Token Expires, Please Login Again');
      RouteNavigators.routeNoWayHome(
        context,
        const SignInScreen(),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    ProfileDetailsModel datails = ref.watch(profileProvider);
    initialAction();
    return Scaffold(
      body: Padded(
        child: Column(
          children: [
            yMargin(75),
            CircleAvatar(
              maxRadius: getScreenHeight(50),
              backgroundImage: NetworkImage(datails.image ??
                  'https://res.cloudinary.com/ddgtlk2h3/image/upload/v1699368743/F26wrniX0AAFG3h_dggxg6.jpg'),
            ),
            yMargin(20),
            Center(
              child: Text(
                'Profile Information',
                style: kTextStyleCustom(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            yMargin(10),
            InfoOutlet(name: 'Username', subTitle: datails.username ?? ''),
            InfoOutlet(
              name: 'Email',
              subTitle: datails.email ?? '',
            ),
            InfoOutlet(
              name: 'Phone',
              subTitle: datails.phone ?? '',
            ),
            InfoOutlet(
              name: 'Address',
              subTitle: datails.address ?? '',
            ),
            yMargin(20),
            Text(
              'Thanks for going through our app flow',
              style: kTextStyleCustom(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            yMargin(75),
            InkWell(
              onTap: () async {
                Helper.clearStorage();
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
                RouteNavigators.routeNoWayHome(
                  context,
                  const SignInScreen(),
                );
              },
              child: Text(
                'Sign Out',
                style: kTextStyleCustom(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoOutlet extends StatelessWidget {
  const InfoOutlet({
    super.key,
    required this.name,
    required this.subTitle,
  });
  final String name, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getScreenHeight(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$name:',
            style: kTextStyleCustom(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subTitle,
            style: kTextStyleCustom(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
