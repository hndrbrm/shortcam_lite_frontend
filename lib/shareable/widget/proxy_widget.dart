// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';

typedef ProxyBuilder<T> = Widget Function(BuildContext context, T object);

final class ObjectProxy<T> extends StatelessWidget {
  const ObjectProxy({
    super.key,
    required this.object,
    required this.builder,
  });

  final T object;
  final ProxyBuilder<T> builder;

  @override
  Widget build(BuildContext context) => builder(context, object);
}

final class ChildrenProxy extends ObjectProxy<List<Widget>> {
  const ChildrenProxy({
    super.key,
    required List<Widget> children,
    required super.builder,
  })
  : super(object: children);
}

final class ChildProxy extends ObjectProxy<Widget> {
  const ChildProxy({
    super.key,
    required Widget child,
    required super.builder,
  })
  : super(object: child);
}
