// Copyright 2024. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TvCanClick extends StatelessWidget {
  const TvCanClick({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Shortcuts(
    shortcuts: <LogicalKeySet, Intent>{
      LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
    },
    child: child,
  );
}
