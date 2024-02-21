// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../shareable/widget/child_a_or_b.dart';
import '../../shareable/widget/proxy_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    Widget? title,
    double? width,
  })
  : _title = title,
    _width = width ?? 100.0;

  final Widget? _title;
  final double _width;

  @override
  Widget build(BuildContext context) => ChildProxy(
    child: _Body(width: _width),
    builder: (BuildContext context, Widget child) => ChildAOrB(
      determine: Scaffold.maybeOf(context) == null,
      childA: Scaffold(
        appBar: _title != null ? AppBar(title: _title) : null,
        body: child,
      ),
      childB: child,
    ),
  );
}

final class _Body extends StatelessWidget {
  const _Body({
    double? width,
  })
  : _width = width ?? 100.0;

  final double _width;

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor,
            blurRadius: 48.0,
            spreadRadius: 0.1,
            offset: const Offset(0.0, 1.0),
          ),
        ],
      ),
      child: Lottie.asset(
        'lottie/large_loading.zip',
        width: _width,
      ),
    ),
  );
}
