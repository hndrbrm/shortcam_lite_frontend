// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:shortcam_lite_api/shortcam_lite_api.dart';

import '../../../shareable/data/data.dart';
import '../../../shareable/data/language_data.dart';
import '../../../shareable/data/loading_data.dart';
import '../http/short_cam_lite_client.dart';

export 'package:shortcam_lite_api/shortcam_lite_api.dart' show DeviceInfo;

mixin _DeviceInfoFetcher {
  Loading? get _loading;
  DeviceInfoAmendment get _amendment;
  Language? get _language;

  DeviceInfoEndpoint get _deviceInfoEndpoint => DeviceInfoEndpoint(
    inner: ShortCamLiteClient(
      loading: _loading,
      language: _language,
    ),
  );

  Future<void> fetch() async {
    final deviceInfo = await _deviceInfoEndpoint.fetch();
    _amendment.value = deviceInfo;
  }
}

final class DeviceInfoAmendment
  extends Amendment<DeviceInfo?>
  with _DeviceInfoFetcher
{
  DeviceInfoAmendment(
    super.value, {
    Loading? loading,
    Language? language,
  })
  : _loading = loading,
    _language = language;

  @override
  final Loading? _loading;

  @override
  final Language? _language;

  @override
  DeviceInfoAmendment get _amendment => this;
}

final class _DeviceInfoAncestor extends Ancestor<DeviceInfoAmendment> {
  const _DeviceInfoAncestor({
    required super.amendment,
    required super.child,
  });
}

final class DeviceInfoInheritor extends Inheritor<_DeviceInfoAncestor, DeviceInfoAmendment, DeviceInfo?> {
  const DeviceInfoInheritor({
    super.key,
    required super.builder,
  });
}

final class DeviceInfoScope extends StatefulWidget {
  const DeviceInfoScope({
    super.key,
    required Widget child,
  })
  : _child = child;

  final Widget _child;

  @override
  State<DeviceInfoScope> createState() => _DeviceInfoScopeState();
}

class _DeviceInfoScopeState extends ScopedState<DeviceInfoScope, DeviceInfoAmendment> {
  @override
  late final DeviceInfoAmendment amendment;

  @override
  void initState() {
    super.initState();

    amendment = DeviceInfoAmendment(
      null,
      loading: LoadingAmendment.sniff(context),
      language: LanguageAmendment.sniff(context),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    amendment.fetch();
  }

  @override
  Widget build(BuildContext context) => _DeviceInfoAncestor(
    amendment: amendment,
    child: widget._child,
  );
}
