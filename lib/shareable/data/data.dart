// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

typedef SnifferBuilder<N extends Amendment> = Widget Function(
  N amendment,
);

typedef InheritorBuilder<N extends Amendment<I>, I> = Widget Function(
  N amendment,
  I inheritance,
);

class Amendment<I> extends ValueNotifier<I> {
  Amendment(super.value);

  bool _disposed = false;

  static N? sniff<A extends Ancestor<N>, N extends Amendment<I>, I>(BuildContext context) =>
    Ancestor.sniff<A, N, I>(context)?._amendment;

  static N? inherit<A extends Ancestor<N>, N extends Amendment<I>, I>(BuildContext context) =>
    Ancestor.inherit<A, N, I>(context)?._amendment;

  @override
  set value(I newValue) {
    if (!_disposed) {
      super.value = newValue;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }
}

class Ancestor<N extends Amendment> extends InheritedNotifier<N> {
  const Ancestor({
    super.key,
    required N amendment,
    required super.child,
  })
  : super(notifier: amendment);

  N get _amendment => super.notifier!;

  static A? sniff<A extends Ancestor<N>, N extends Amendment<I>, I>(BuildContext context) =>
    context.getInheritedWidgetOfExactType<A>();

  static A? inherit<A extends Ancestor<N>, N extends Amendment<I>, I>(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<A>();
}

class Sniffer<A extends Ancestor<N>, N extends Amendment<I>, I> extends StatelessWidget {
  const Sniffer({
    super.key,
    required SnifferBuilder<N> builder,
  })
  : _builder = builder;

  final SnifferBuilder<N> _builder;

  @override
  Widget build(BuildContext context) => _builder(
    Ancestor.sniff<A, N, I>(context)!._amendment,
  );
}

class Inheritor<A extends Ancestor<N>, N extends Amendment<I>, I> extends StatelessWidget {
  const Inheritor({
    super.key,
    required InheritorBuilder<N, I> builder,
  })
  : _builder = builder;

  final InheritorBuilder<N, I> _builder;

  @override
  Widget build(BuildContext context) => _builder(
    Ancestor.inherit<A, N, I>(context)!._amendment,
    Ancestor.inherit<A, N, I>(context)!._amendment.value,
  );
}

abstract class ScopedState<T extends StatefulWidget, N extends Amendment> extends State<T> {
  N get amendment;

  @override
  void dispose() {
    amendment.dispose();
    super.dispose();
  }
}
