// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'data.dart';

export 'data.dart' show ScopedState;

class BoolAmendment extends Amendment<bool> {
  BoolAmendment(super.value);

  static N? sniff<A extends BoolAncestor<N>, N extends BoolAmendment>(BuildContext context) =>
    Amendment.sniff<A, N, bool>(context);

  static N? inherit<A extends BoolAncestor<N>, N extends BoolAmendment>(BuildContext context) =>
    Amendment.inherit<A, N, bool>(context);
}

class BoolAncestor<N extends BoolAmendment> extends Ancestor<N> {
  const BoolAncestor({
    super.key,
    required super.amendment,
    required super.child,
  });

  static A? sniff<A extends BoolAncestor<N>, N extends BoolAmendment>(BuildContext context) =>
    Ancestor.sniff<A, N, bool>(context);

  static A? inherit<A extends BoolAncestor<N>, N extends BoolAmendment>(BuildContext context) =>
    Ancestor.inherit<A, N, bool>(context);
}

class BoolSniffer<A extends BoolAncestor<N>, N extends BoolAmendment> extends Sniffer<A, N, bool> {
  const BoolSniffer({
    super.key,
    required super.builder,
  });
}

class BoolInheritor<A extends BoolAncestor<N>, N extends BoolAmendment> extends Inheritor<A, N, bool> {
  const BoolInheritor({
    super.key,
    required super.builder,
  });
}
