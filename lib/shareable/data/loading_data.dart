// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../next_frame.dart';
import 'bool_data.dart';
import 'data.dart';

abstract interface class Loading {
  bool getLoading();
  FutureOr<void> setLoading(bool value);
}

mixin _Loading implements Loading {
  LoadingAmendment get _amendment;

  @override
  bool getLoading() => _amendment.value;

  @override
  FutureOr<void> setLoading(bool value) => NextFrame.run(
    () => _amendment.value = value,
  );
}

final class _Counter {
  _Counter();

  int value = 0;
}

final class LoadingAmendment extends BoolAmendment with _Loading {
  LoadingAmendment(super.value)
  : _counter = _Counter();

  final _Counter _counter;

  static LoadingAmendment? sniff(BuildContext context) =>
    BoolAmendment.sniff<LoadingAncestor, LoadingAmendment>(context);

  static LoadingAmendment? inherit(BuildContext context) =>
    BoolAmendment.inherit<LoadingAncestor, LoadingAmendment>(context);

  @override
  set value(bool newValue) {
    final current = _counter.value > 0;
    _counter.value += newValue ? 1 : -1;
    final next = _counter.value > 0;

    if (current != next) {
      super.value = newValue;
    }
  }

  @override
  LoadingAmendment get _amendment => this;
}

final class LoadingAncestor extends BoolAncestor<LoadingAmendment> {
  const LoadingAncestor({
    super.key,
    required super.amendment,
    required super.child,
  });

  static LoadingAncestor? sniff(BuildContext context) =>
    Ancestor.sniff<LoadingAncestor, LoadingAmendment, bool>(context);

  static LoadingAncestor? inherit(BuildContext context) =>
    Ancestor.inherit<LoadingAncestor, LoadingAmendment, bool>(context);
}

final class LoadingSniffer extends BoolSniffer<LoadingAncestor, LoadingAmendment> {
  const LoadingSniffer({
    super.key,
    required super.builder,
  });
}

final class LoadingInheritor extends BoolInheritor<LoadingAncestor, LoadingAmendment> {
  const LoadingInheritor({
    super.key,
    required super.builder,
  });
}

final class LoadingScope extends StatefulWidget {
  const LoadingScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<LoadingScope> createState() => _LoadingScopeState();
}

final class _LoadingScopeState extends ScopedState<LoadingScope, LoadingAmendment> {
  @override
  final LoadingAmendment amendment = LoadingAmendment(false);

  @override
  Widget build(BuildContext context) => LoadingAncestor(
    amendment: amendment,
    child: widget.child,
  );
}
