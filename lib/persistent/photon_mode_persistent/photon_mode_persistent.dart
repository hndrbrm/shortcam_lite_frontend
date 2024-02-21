// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

part of '../persistent.dart';

abstract interface class PhotonModePersistent {
  factory PhotonModePersistent({
    Loading? loading,
  }) = _PhotonModePreferences;

  FutureOr<PhotonMode> loadPhotonMode();

  FutureOr<void> savePhotonMode(PhotonMode value);

  FutureOr<void> clearPhotonMode();
}
