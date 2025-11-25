import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

InputBorder mainEnabledInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none);
BorderRadiusGeometry mainBorder = BorderRadius.all(Radius.circular(12.r));
BorderRadiusGeometry mainBorderWith12 = BorderRadius.all(Radius.circular(12.r));
BoxDecoration mainShapeDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12.r),
  // boxShadow: const [
  //   BoxShadow(
  //     color: Color(0x14000000),
  //     blurRadius: 4,
  //     offset: Offset(1, 0),
  //     spreadRadius: 0,
  //   )
  // ],
);

ShapeDecoration mainShapeDecoration12 = ShapeDecoration(
  color: Colors.white,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
  // shadows: const [
  //   BoxShadow(
  //     color: Color(0x14000000),
  //     blurRadius: 4,
  //     offset: Offset(1, 0),
  //     spreadRadius: 0,
  //   )
  // ],
);

ShapeDecoration borderRidusSideDecoration = ShapeDecoration(
  color: Colors.white,
  shape: RoundedRectangleBorder(
    side: const BorderSide(
      width: 0.40,
      strokeAlign: BorderSide.strokeAlignOutside,
      color: Color(0xFFB5B6B6),
    ),
    borderRadius: BorderRadius.circular(12),
  ),
);

ShapeDecoration mainFilterDecoration() {
  return ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      side: BorderSide(width: .7.sp, color: cGreyEBEBEB),
      borderRadius: BorderRadius.circular(12.r),
    ),
  );
}

BoxDecoration dWhite12Radius = BoxDecoration(
  color: cWhiteColor,
  borderRadius: BorderRadius.circular(12.r),
);
BoxDecoration dGrey12Radius = BoxDecoration(
  color: cLightGreyColor,
  borderRadius: BorderRadius.circular(12.r),
);
BoxDecoration dWhite16RadiusWithShadow = BoxDecoration(
  color: cWhiteColor,
  boxShadow: const [
    BoxShadow(
      color: Color(0x1A000000), // Shadow color with 10% opacity
      // No spread
      blurRadius: 5, // Blur radius
      // Offset in x and y direction
    ),
  ],
  borderRadius: BorderRadius.circular(12.r),
);
BoxDecoration dWhite24RadiusWithShadow = BoxDecoration(
  color: cWhiteColor,
  boxShadow: const [
    BoxShadow(
      color: Color(0x1A000000), // Shadow color with 10% opacity
      // No spread
      blurRadius: 5, // Blur radius
      // Offset in x and y direction
    ),
  ],
  borderRadius: BorderRadius.circular(24.r),
);
