// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

part of '../persistent.dart';

abstract interface class LocalePersistent {
  factory LocalePersistent({
    Loading? loading,
  }) = _LocalePreferences;

  FutureOr<Locale?> loadLocale();

  FutureOr<void> saveLocale(Locale value);

  FutureOr<void> clearLocale();
}
