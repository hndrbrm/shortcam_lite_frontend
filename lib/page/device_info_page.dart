// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../shareable/data/language_data.dart';

final class DeviceInfoPage extends StatelessWidget {
  const DeviceInfoPage({ super.key });

  @override
  Widget build(BuildContext context) => LanguageInheritor(
    builder: (_, language) => Scaffold(
      appBar: AppBar(
        title: Text(language.deviceInfo),
      ),
      body: Container(),
    ),
  );
}
