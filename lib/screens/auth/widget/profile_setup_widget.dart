import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/dimensions.dart';

class CountryListWidget extends StatelessWidget {
  const CountryListWidget({
    super.key,
    required this.countryName,
    required this.countryAbbrevation,
    required this.imagePath,
    required this.currentIndex,
    required this.selectedIndex,
    this.onTap,
  });
  final String countryName, countryAbbrevation, imagePath;
  final int currentIndex, selectedIndex;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            getScreenHeight(16),
          ),
          color:
              currentIndex == selectedIndex ? kTEXTFIELDBACKGROUND : kWHTCOLOUR,
        ),
        height: getScreenHeight(64),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getScreenWidth(16),
          ),
          child: Row(
            children: [
              SizedBox(
                height: getScreenHeight(24),
                width: getScreenWidth(32),
                child: SvgPicture.asset(imagePath),
              ),
              xMargin(16),
              Text.rich(
                TextSpan(
                  text: '$countryAbbrevation ',
                  children: [
                    TextSpan(
                      text: countryName,
                      style: kTextStyleCustom(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                  style: kTextStyleCustom(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: kLightGray),
                ),
              ),
              currentIndex == selectedIndex
                  ? Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                            height: getScreenHeight(24),
                            width: getScreenWidth(24),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child:
                                  SvgPicture.asset('assets/svgs/checkmark.svg'),
                            )),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
