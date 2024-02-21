// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data/photon_mode/photon_mode.dart';

class ThemeConfig {
  const ThemeConfig._();

  static const MaterialColor primarySwatch = Colors.orange;
  static const Color primaryColor = Color.fromARGB(0xff, 0x00, 0x00, 0x8f);

  static const PhotonMode defaultPhotonMode = PhotonMode.system;
  static const String defaultFontFamily = 'Roboto Condensed';
  static const double dividerSpace = 8.0;

  static const Color sellColor = Color(0xFFB92E4E);
  static const Color buyColor = Color(0xff15a668);
}

extension ThemeDataExtension on ThemeData {
  Color get fillColor => brightness == Brightness.light
    ? const Color(0xfff1f2f7)
    : const Color(0xff232426);

  Color get inputHintColor => brightness == Brightness.light
    ? const Color(0xffc6c7cf)
    : const Color(0xff7e7b85);

  TextStyle get columnTitle => TextStyle(color: inputHintColor);
}
