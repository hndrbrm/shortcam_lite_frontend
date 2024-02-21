// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';

import '../../shareable/data/loading_data.dart';
import '../../shareable/widget/child_a_or_b.dart';
import 'loading_widget.dart';

class InheritedLoading extends StatelessWidget {
  const InheritedLoading({
    super.key,
    Widget? loading,
  })
  : _loading = loading ?? const LoadingWidget();

  final Widget _loading;

  @override
  Widget build(BuildContext context) => LoadingInheritor(
    builder: (LoadingAmendment amendment, __) => Visibility(
      visible: amendment.getLoading(),
      child: _loading,
    ),
  );
}

class WrapWithLoading extends StatelessWidget {
  const WrapWithLoading({
    super.key,
    Widget? loading,
    required Widget child,
  })
  : _loading = loading ?? const LoadingWidget(),
    _child = child;

  final Widget _loading;
  final Widget _child;

  @override
  Widget build(BuildContext context) => LoadingInheritor(
    builder: (LoadingAmendment amendment, __) => ChildAOrB(
      determine: amendment.getLoading(),
      childA: _loading,
      childB: _child,
    ),
  );
}
