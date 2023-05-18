import 'package:flutter/material.dart';
import 'package:savelife_web/constants/colors.dart';
import 'package:savelife_web/constants/sizes.dart';

class AElevatedButtonTheme {
  AElevatedButtonTheme._(); //To Avoid Creating instance

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      foregroundColor: aWhiteColor,
      backgroundColor: aSecondaryCOlor,
      side: const BorderSide(color: aSecondaryCOlor),
      padding: const EdgeInsets.symmetric(vertical: aButtonHeight),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      foregroundColor: aSecondaryCOlor,
      backgroundColor: aWhiteColor,
      side: const BorderSide(color: aSecondaryCOlor),
      padding: const EdgeInsets.symmetric(vertical: aButtonHeight),
    ),
  );
}
