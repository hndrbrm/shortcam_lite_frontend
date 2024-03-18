// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../page/device_page_library/device_page_library.dart';
import '../shareable/navigator_helper.dart';
import '../shareable/route/page_builder_generator.dart';

final class DeviceRoute with PageGenerator {
  const DeviceRoute();

  static const String name = '/device';

  @override
  String get pageName => name;

  @override
  WidgetBuilder generateBuilder(RouteSettings settings) =>
    (BuildContext context) => const DevicePage();
}

final class DeviceNavigator {
  const DeviceNavigator({
    this.navigator,
  });

  final NavigatorHelper? navigator;

  NavigatorHelper get _navigator => navigator ?? const NavigatorHelper();

  Future<T?> pushNamed<T extends Object?>() => _navigator.pushNamed(
    DeviceRoute.name,
  );
}
