// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

final class NavigatorHelper {
  const NavigatorHelper({
    GlobalKey<NavigatorState>? key,
  })
  : key = key ?? const _NavigatorKey();

  final GlobalKey<NavigatorState> key;

  NavigatorState get _navigator => key.currentState!;

  get pushNamed => _navigator.pushNamed;
  get pushNamedAndRemoveUntil => _navigator.pushNamedAndRemoveUntil;
  get pushReplacementNamed => _navigator.pushReplacementNamed;

  get pop => _navigator.pop;

  get canPop => _navigator.canPop;
}

// One instance for the whole app lifetime, hence the 'const', and zero field.
final class _NavigatorKey extends GlobalKey<NavigatorState> {
  const _NavigatorKey() : super.constructor();
}

// Single navigator for the whole app lifetime, hence the single instance.
//
// Avoid using singleton, using a long construction such as Foo.instance,
// make it longer to type, and using Foo() hide the singleton nature on
// the implementation.
//
// Put the navigator key to the MaterialApp
// example:
// MaterialApp(
//   navigatorKey: navigator.key,
//   ...
const NavigatorHelper navigator = NavigatorHelper();
