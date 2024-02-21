// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:ui';

/// Enable the behaviour of click and drag on Stylus tab such as Galaxy Tab.
///
/// Example:
/// MaterialApp(
///   scrollBehavior: MyScrollBehavior(),
///   ...
///
/// class MyScrollBehavior extends MaterialScrollBehavior with StylusAlsoScroll {
///   @override
///   Set<PointerDeviceKind> get dragDevices => {
///     ...super.dragDevices,
///     ...const StylusAlsoScroll().dragDevices,
///   };
/// ...
/// }
final class StylusAlsoScroll {
  const StylusAlsoScroll();

  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
  };
}
