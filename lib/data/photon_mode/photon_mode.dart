// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum PhotonMode {
  system,
  automatic,
  dark,
  light,
}

extension PhotonModeExtension on PhotonMode {
  String descriptionFrom(AppLocalizations language) => switch (this) {
    PhotonMode.system => language.systemPhotonModeDescription,
    PhotonMode.automatic => language.automaticPhotonModeDescription,
    PhotonMode.dark => language.darkPhotonModeDescription,
    PhotonMode.light => language.lightPhotonModeDescription,
  };

  String nameFrom(AppLocalizations language) => switch (this) {
    PhotonMode.system => language.systemPhotonMode,
    PhotonMode.automatic => language.automaticPhotonMode,
    PhotonMode.dark => language.darkPhotonMode,
    PhotonMode.light => language.lightPhotonMode,
  };
}
