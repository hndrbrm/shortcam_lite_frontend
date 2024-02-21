// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:ui';

export 'dart:ui' show PointerDeviceKind;

/// Enable the behaviour of click and drag on Macos, Windows, Linux.
///
/// Example:
/// MaterialApp(
///   scrollBehavior: MyScrollBehavior(),
///   ...
///
/// class MyScrollBehavior extends MaterialScrollBehavior {
///   @override
///   Set<PointerDeviceKind> get dragDevices => {
///     ...super.dragDevices,
///     ...const DesktopAlsoScroll().dragDevices,
///   };
/// ...
/// }
final class DesktopAlsoScroll {
  const DesktopAlsoScroll();

  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
