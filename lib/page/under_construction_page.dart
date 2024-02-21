// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../shareable/data/language_data.dart';
import '../shareable/navigator_helper.dart';

final class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({ super.key });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: navigator.canPop() ? AppBar() : null,
    body: CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          child: Center(
            child: LanguageInheritor(
              builder: (_, AppLocalizations language) => Text(language.underConstruction),
            ),
          ),
        ),
      ],
    ),
  );
}
