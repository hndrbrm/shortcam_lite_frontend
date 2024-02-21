// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'page_builder_generator.dart';

export 'page_builder_generator.dart' show PageGenerator;

final class GenerateRouteHandler {
  const GenerateRouteHandler({
    this.pageBuilderProxy,
    this.builders,
  });

  final PageBuilderProxy? pageBuilderProxy;
  final List<PageGenerator>? builders;

  Route? handleGenerateRoute<T>(RouteSettings settings) {
    for (final PageGenerator builder in builders ?? []) {
      final Route? route = builder.generateRoute(settings, pageBuilderProxy);
      if (route != null) {
        return route;
      }
    }

    return null;
  }
}
