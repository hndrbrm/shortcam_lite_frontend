// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:shortcam_lite_frontend/shareable/data/language_data.dart';

import '../route/device_route.dart';

final class HomePage extends StatelessWidget {
  const HomePage({ super.key });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          child: Center(
            child: TextButton(
              child: LanguageInheritor(
                builder: (_, language) => Text(language.openDevice),
              ),
              onPressed: () => const DeviceNavigator().pushNamed(),
            ),
          ),
        ),
      ],
    ),
  );
}
