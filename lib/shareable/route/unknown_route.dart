// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'page_builder_proxy.dart';

final class UnknownRouteHandler {
  const UnknownRouteHandler({
    this.pageBuilderProxy,
    required this.page,
  });

  final PageBuilderProxy? pageBuilderProxy;
  final Widget page;

  Route? handleUnknownRoute(RouteSettings settings) => MaterialPageRoute(
    builder: (BuildContext context) => pageBuilderProxy!(context, settings, page),
    settings: settings,
  );
}
