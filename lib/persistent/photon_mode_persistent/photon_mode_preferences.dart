// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

part of '../persistent.dart';

final class _PhotonModePreferences implements PhotonModePersistent {
  const _PhotonModePreferences({
    Loading? loading,
  })
  : _loading = loading;
  
  final Loading? _loading;

  // This key must be unique relative to others Preferences.
  static const String _key = 'photon_mode';

  _PreferencesHelper get _helper => _PreferencesHelper(loading: _loading);

  @override
  FutureOr<PhotonMode> loadPhotonMode() async {
    final String? value = await _helper.getString(_key);
    return value?.toPhotonMode() ?? ThemeConfig.defaultPhotonMode;
  }

  @override
  FutureOr<void> savePhotonMode(PhotonMode value) =>
    _helper.setString(_key, value.toPersistentString());

  @override
  FutureOr<void> clearPhotonMode() =>
    _helper.removePreference(_key);
}

extension _StringExtension on String {
  PhotonMode toPhotonMode() {
    if (this == 'system') {
      return PhotonMode.system;
    }

    if (this == 'automatic') {
      return PhotonMode.automatic;
    }

    if (this == 'dark') {
      return PhotonMode.dark;
    }

    if (this == 'light') {
      return PhotonMode.light;
    }

    return ThemeConfig.defaultPhotonMode;
  }
}

extension _PhotonModeExtension on PhotonMode {
  String toPersistentString() => switch (this) {
    PhotonMode.system => 'system',
    PhotonMode.automatic => 'automatic',
    PhotonMode.dark => 'dark',
    PhotonMode.light => 'light',
  };
}
