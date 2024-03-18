// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data/device_info_data.dart';
import '../data/loading/inherited_loading.dart';
import '../shareable/data/language_data.dart';

final class DeviceInfoPage extends StatelessWidget {
  const DeviceInfoPage({ super.key });

  @override
  Widget build(BuildContext context) => LanguageInheritor(
    builder: (_, language) => Scaffold(
      appBar: AppBar(
        title: Text(language.deviceInfo),
      ),
      body: Stack(
        children: <Widget>[
          DeviceInfoScope(
            child: DeviceInfoInheritor(
              builder: (_, DeviceInfo? deviceInfo) => GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 8.0,
                children: <Widget>[
                  if (deviceInfo != null) ...[
                    const Text('Name'),
                    Text(deviceInfo.name.orEmpty()),
                    const Text('Country'),
                    Text(deviceInfo.country.orEmpty()),
                    const Text('Mac'),
                    Text(deviceInfo.mac.orEmpty()),
                    const Text('Serial'),
                    Text(deviceInfo.serial.orEmpty()),
                    const Text('Vendor'),
                    Text(deviceInfo.vendor.orEmpty()),
                    const Text('Firmware Version'),
                    Text(deviceInfo.version.firmwareVersion.orEmpty()),
                    const Text('Firmware Build Time'),
                    Text(deviceInfo.version.firmwareBuildTime.orEmpty()),
                    const Text('Firmware Rom Version'),
                    Text(deviceInfo.version.romVersion.orEmpty()),
                    const Text('Firmware Rom Build Time'),
                    Text(deviceInfo.version.romBuildTime.orEmpty()),
                    const Text('Firmware Flash Version'),
                    Text(deviceInfo.version.flashVersion.orEmpty()),
                    const Text('Firmware Flash Build Time'),
                    Text(deviceInfo.version.flashBuildTime.orEmpty()),
                  ],
                ],
              ),
            ),
          ),
          const InheritedLoading(),
        ],
      ),
    ),
  );
}

extension on String {
  String orEmpty() => isEmpty ? '-' : this;
}
