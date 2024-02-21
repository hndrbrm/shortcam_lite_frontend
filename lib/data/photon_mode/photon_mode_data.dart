// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../persistent/persistent.dart';
import '../../shareable/data/data.dart';
import '../../shareable/data/loading_data.dart';
import '../../shareable/future_or_extension.dart';
import '../../shareable/widget/element_event_library/element_event_library.dart';
import 'photon_mode.dart';

export 'photon_mode.dart' show PhotonMode;

mixin _PhotonModeLoader {
  PhotonModePersistent get _photonModePersistent;
  PhotonModeAmendment get _amendment;

  FutureOr<void> loadPhotonMode() => _photonModePersistent.loadPhotonMode()
    .then((value) => _amendment.value = value);
}

mixin _PhotonModeSaver {
  PhotonModePersistent get _photonModePersistent;
  PhotonModeAmendment get _amendment;

  FutureOr<void> savePhotonMode(PhotonMode? newValue) => switch (newValue) {
    null => _photonModePersistent.clearPhotonMode(),
    _ => _photonModePersistent.savePhotonMode(newValue),
  }.then(
    (_) => _amendment.value = newValue,
  );
}

mixin _ToThemeMode {
  PhotonModeAmendment get _amendment;

  ThemeMode toThemeMode() => switch (_amendment.value) {
    PhotonMode.system => ThemeMode.system,
    PhotonMode.automatic => _calculate(),
    PhotonMode.dark => ThemeMode.dark,
    PhotonMode.light => ThemeMode.light,
    _ => ThemeMode.system,
  };

  ThemeMode _calculate() {
    int nowHour = DateTime.now().hour;
    bool isDarkMode = nowHour <= 6 || nowHour >= 18;
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}

final class PhotonModeAmendment
  extends Amendment<PhotonMode?>
  with _PhotonModeLoader, _PhotonModeSaver, _ToThemeMode
{
  PhotonModeAmendment(
    super.value, {
    Loading? loading,
  })
  :_photonModePersistent = PhotonModePersistent(loading: loading);

  @override
  final PhotonModePersistent _photonModePersistent;

  @override
  PhotonModeAmendment get _amendment => this;
}

final class _PhotonModeAncestor extends Ancestor<PhotonModeAmendment> {
  const _PhotonModeAncestor({
    required super.amendment,
    required super.child,
  });
}

final class PhotonModeSniffer extends Sniffer<_PhotonModeAncestor, PhotonModeAmendment, PhotonMode?> {
  const PhotonModeSniffer({
    super.key,
    required super.builder,
  });
}

final class PhotonModeInheritor extends Inheritor<_PhotonModeAncestor, PhotonModeAmendment, PhotonMode?> {
  const PhotonModeInheritor({
    super.key,
    required super.builder,
  });
}

final class _PhotonModeInit extends StatelessWidget with CallbackForStatelessWidget {
  const _PhotonModeInit({
    required PhotonModeAmendment amendment,
    required Widget child,
  })
  : _amendment = amendment,
    _child = child;

  final PhotonModeAmendment _amendment;
  final Widget _child;

  @override
  void onMount(BuildContext context) {
    super.onMount(context);
    _amendment.loadPhotonMode();
  }

  @override
  Widget build(BuildContext context) => _child;
}

final class PhotonModeScope extends StatefulWidget {
  const PhotonModeScope({
    super.key,
    required Widget child,
  })
  : _child = child;

  final Widget _child;

  @override
  State<PhotonModeScope> createState() => _PhotonModeScopeState();
}

final class _PhotonModeScopeState extends ScopedState<PhotonModeScope, PhotonModeAmendment> {
  @override
  late final PhotonModeAmendment amendment;

  @override
  void initState() {
    super.initState();

    amendment = PhotonModeAmendment(
      ThemeConfig.defaultPhotonMode,
      loading: LoadingAmendment.sniff(context),
    );
  }

  @override
  Widget build(BuildContext context) => _PhotonModeAncestor(
    amendment: amendment,
    child: _PhotonModeInit(
      amendment: amendment,
      child: widget._child,
    ),
  );
}
