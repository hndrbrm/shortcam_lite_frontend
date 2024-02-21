// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/theme.dart';

final class SingularThemeData {
  static ThemeData light() => ThemeData.light(
    useMaterial3: true,
  ).applyBase();

  static ThemeData dark() => ThemeData.dark(
    useMaterial3: true,
  ).applyBase();
}

extension _ThemeDataExtension on ThemeData {
  ThemeData applyBase() => copyWith(
    dividerTheme: dividerTheme.copyWith(
      space: ThemeConfig.dividerSpace,
    ),
    textTheme: textTheme.apply(
      fontFamily: GoogleFonts.getFont(ThemeConfig.defaultFontFamily).fontFamily,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: ThemeConfig.primarySwatch,
      brightness: brightness,
    ),
    primaryColor: ThemeConfig.primaryColor,
  );
}
