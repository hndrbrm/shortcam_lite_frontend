// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'page_builder_proxy.dart';

export 'page_builder_proxy.dart' show PageBuilderProxy;

abstract mixin class PageGenerator {
  const PageGenerator();

  String get pageName;

  WidgetBuilder generateBuilder(RouteSettings settings);

  Route<T>? generateRoute<T>(RouteSettings settings, [ PageBuilderProxy? proxy ]) {
    if (settings.name == pageName) {
      final WidgetBuilder builder = generateBuilder(settings);

      return MaterialPageRoute<T>(
        builder: proxy?.toBuilder(settings, builder) ?? builder,
        settings: settings,
      );
    }

    return null;
  }
}

extension on PageBuilderProxy {
  WidgetBuilder toBuilder(
    RouteSettings settings,
    WidgetBuilder pageBuilder,
  ) => (BuildContext context) => this(
    context,
    settings,
    pageBuilder(context),
  );
}
