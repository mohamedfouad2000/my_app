import 'package:flutter/material.dart';

const cPrimaryColor = Color(0xffBD924A);
const cSecondaryColor = Color(0xffDBB26D);
const cSecondary415F59 = Color(0xff415F59);
const cSecondary70 = Color(0xffE2E9E7);
const cSecondary300 = Color(0xff607974);

const cSecondary50 = Color(0xffE7EBEA);

const cBackPrimaryColor = Color(0xffBD924A);
const cPrimaryOpacityColor = Color(0xffEEE9E1);

const cLightPrimaryColor = Color(0xffBDEEE8);
const cprimaryYellow = Color(0xFFF7F3EC);

const cWhiteColor = Color(0xffffffff);
const cGreyColor8F8F8F = Color(0xff8F8F8F);
const cGreyColorF0F0F0 = Color(0xffF0F0F0);

      const cBirthdayCardColor = Color(0xff453A64);

// const cBlackColor = Color(0xff35373B);
const cBlackColor = Colors.black;

const surfaceColor = Color(0xffF8F8F8);
const cLightBlackColor = Color(0xff3C3C3C);
const cThColor = Color(0xffD1C2A9);
const textColor50 = Color(0xffE6E6E6);
const textColor400 = Color(0xff383A39);
const textColor300 = Color(0xff585A59);
const textColor500 = Color(0xff060907);
const textColor900 = Color(0xff353537);
const greyEBEBEB = Color(0xffEBEBEB);
const grey424445 = Color(0xff424445);
const grey737377 = Color(0xff737377);
const whiteF8F8F8 = Color(0xfff8f8f8);
const whiteF8F4ED = Color(0xffF8F4ED);
const whiteF3EBDD = Color(0xffF3EBDD);
const iconPrimary = Color(0xff17263C);
const textColor100 = Color(0xffB2B3B2);
const textColor200 = Color(0xff8C8E8D);
const textColor600 = Color(0xff050806);

const cYellowColor = Color.fromRGBO(255, 193, 7, 1);
const cYellowF3EBDD = Color(0xffF3EBDD);
const cDisabledColor = Color(0xffE1D8CA);

const cRedColor = Color(0xffDB3529);
const cFailedColor = Color(0xffE31414);
const cErrorFF0000 = Color(0xffFF0000);

const credE00000 = Color(0xffE00000);
const credFCE6E6 = Color(0xffFCE6E6);
const cGreenColor3EA05A = Color(0xff3EA05A);
const cGreen089D15 = Color(0xff089D15);

const cSuggestColor = Color(0xFF5A5E63);
const cGreyColor = Color(0xff9E9E9E);
const cGreyColor2 = Color(0xff5B5C5C);
const cGreyColor3 = Color(0xFF474747);
const cGreyColor4 = Color(0xff929292);
const cGreyColor5 = Color(0xFF3A3A37);
const cGreyColor6 = Color(0xFFEAEAEA);

const cGreyColor7 = Color(0xFFB5B6B6);
const cGreyColor8 = Color(0xFFA9A9AC);

const cGreyColor9 = Color(0xFFF2F2F3);
const cGreyColor10 = Color(0xFF59595D);
const cGreyColor11 = Color(0xFF8C8E8D);
const cGreyColorB9CEC9 = Color(0xFFB9CEC9);

const cGrayText = Color(0xFF6E6E6E);
const unAvailableColor = Color(0xFFBCBCBC);

const cContainerUnselectedColor = Color(0xFFF7F7F7);
const cTextFiledColor = Color(0xffEEEEEE);

const cIconGrayColor = Color(0xff8D8D8D);
const cBackGroundColor = Color(0xfff5f5f5);
const cLightGreyColor = Color(0xffF1F1F1);
const cTextFormedFiledGray = Color(0xffFFFFFF);
const cDarkGreyColor = Color.fromRGBO(210, 210, 210, 0.36);
const cNavigationBarSelectedColor = Color(0xff949494);
const cGreyD2Color = Color(0xffD2D2D2);
const cLightRedColor = Color(0xffFF7474);
const cNewGreyColor = Color(0xff959595);
const cInactiveSwitchColor = Color(0xffD5D5D5);
const cGrayColorContainer = Color(0xffFAFAFB);
const cIconColor = Color(0xff585A59);
const cGrayColor55 = Color(0xFF717172);
const cNavBarLabelColor = Color(0xFF7E7E83);
const cSeeAllColor = Color(0xFF838383);
const cServiceHeaderColor = Color(0xFF404244);
const cSuccColor = Color(0xff2BBE6B);
const cGrayUserColor = Color(0xffC5C5C5);
const cHeaderColor = Color(0xFF29322D);
const dateTimeColor = Color(0xff747574);
const cBorderColor = Color(0xffECECEC);
const cBorderColor2 = Color(0xffB6B6B6);
const cGrayD2DBD9 = Color(0xffD2DBD9);
const cGray383A39 = Color(0xff383A39);
const cGrayF6F6F6 = Color(0xffF6F6F6);
const cRedCB0000 = Color(0xFFCB0000);
const cGreyEBEBEB = Color(0xFFEBEBEB);
const cGreyD7D7D9 = Color(0xFFD7D7D9);
const cGreyB5C1BF = Color(0xFFB5C1BF);

const cYellowE48C00 = Color(0xffE48C00);
const cGrey0xFF484848 = Color(0xFF484848);
const cGrey0xFF333333 = Color(0xFF333333);
const cRed0xffE63333 = Color(0xffE63333);
const cYellow0xffFFF9EE = Color(0xffFFF9EE);

const cGreenColor = Color(0xff008B6D);
const cwhiteF8F4ED = Color(0xffF8F4ED);
const cBlack060907 = Color(0xff060907);
const cBlueCBE4FF = Color(0xffCBE4FF);
const cBlue0048A2 = Color(0xff0048A2);

Color hexToColor(String hexColor) {
  // Remove the leading '#' if it's there
  if (hexColor.startsWith('#')) {
    hexColor = hexColor.substring(1);
  }

  // Convert the hex string to an integer and create a Color object
  return Color(int.parse('0xFF$hexColor'));
}

Map<int, Color> swatch = {
  50: const Color(0xFFF3E4C5), // Lightest shade
  100: const Color(0xFFE1CC8F), // Light shade
  200: const Color(0xFFD0B35A),
  300: const Color(0xFFBD924A), // Main color (0xffBD924A)
  400: const Color(0xFF9E7C3F), // Darker shade
  500: const Color(0xFF8B692F), // Base color
  600: const Color(0xFF7A5A2A),
  700: const Color(0xFF664B23),
  800: const Color(0xFF533C1E), // Darkest shade
  900: const Color(0xFF402E19),
};

MaterialColor customSwatch = MaterialColor(0xFFBD924A, swatch);
const cSecondry500 = Color(0xff11372F);
const cSecondry400 = Color(0xff415F59);
const cSecondaryF3F3F3 = Color(0xffF3F3F3);
const cGreyEFEFEF = Color(0xffEFEFEF);
