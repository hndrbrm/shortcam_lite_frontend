// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

part of '../persistent.dart';

final class _LocalePreferences implements LocalePersistent {
  const _LocalePreferences({
    Loading? loading,
  })
  : _loading = loading;
  
  final Loading? _loading;

  // This key must be unique relative to others Preferences.
  static const String _key = 'locale';

  _PreferencesHelper get _helper => _PreferencesHelper(loading: _loading);

  @override
  FutureOr<Locale?> loadLocale() async =>
    (await _helper.getString(_key))?.toLocale();

  @override
  FutureOr<void> saveLocale(Locale value) =>
    _helper.setString(_key, value.toPersistentString());

  @override
  FutureOr<void> clearLocale() => _helper.removePreference(_key);
}

extension _LocaleExtension on Locale {
  String toPersistentString() {
    final Map<String, String> map = <String, String>{
      'languageCode': languageCode,
      if (countryCode != null)
      'countryCode': countryCode!,
    };

    return jsonEncode(map);
  }
}

extension _StringToLocaleExtension on String {
  Locale toLocale() {
    final Map<String, dynamic> map = jsonDecode(this);

    return Locale(
      map['languageCode'],
      map['countryCode'],
    );
  }
}
