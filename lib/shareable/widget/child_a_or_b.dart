// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';

final class _Element extends ComponentElement {
  _Element(super.widget);

  @override
  Widget build() => (widget as ProxyWidget).child;

  @override
  void update(covariant Widget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild(force: true);
  }
}

final class ChildAOrB extends ProxyWidget {
  const ChildAOrB({
    super.key,
    required bool determine,
    required Widget childA,
    required Widget childB,
  })
  : super(child: determine ? childA : childB);

  @override
  Element createElement() => _Element(this);
}

final class LazyChildAOrB extends ProxyWidget {
  LazyChildAOrB({
    super.key,
    required bool determine,
    required Widget Function() lazyChildA,
    required Widget Function() lazyChildB,
  })
  : super(child: determine ? lazyChildA() : lazyChildB());

  @override
  Element createElement() => _Element(this);
}
