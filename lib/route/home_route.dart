// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../page/device_page_library/device_page_library.dart';
import '../page/home_page.dart';
import '../shareable/navigator_helper.dart';
import '../shareable/route/page_builder_generator.dart';

final class HomeRoute with PageGenerator {
  const HomeRoute();

  static const String name = '/home';

  @override
  String get pageName => name;

  @override
  WidgetBuilder generateBuilder(RouteSettings settings) =>
    (BuildContext context) => const HomePage();
}

final class HomeNavigator {
  const HomeNavigator({
    this.navigator,
  });

  final NavigatorHelper? navigator;

  NavigatorHelper get _navigator => navigator ?? const NavigatorHelper();

  Future<T?> root<T extends Object?>() => _navigator.pushNamedAndRemoveUntil(
    HomeRoute.name,
    (Route route) => false,
  );
}
