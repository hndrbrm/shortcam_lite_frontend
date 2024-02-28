// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:shortcam_lite_api/shortcam_lite_api.dart';

import '../../../shareable/data/data.dart';
import '../../../shareable/data/language_data.dart';
import '../../../shareable/data/loading_data.dart';
import '../http/short_cam_lite_client.dart';

mixin _RtspUrlFetcher {
  Loading? get _loading;
  RtspUrlAmendment get _amendment;
  Language? get _language;

  ChannelRtspEndpoint get _channelRtspEndpoint => ChannelRtspEndpoint(
    inner: ShortCamLiteClient(
      loading: _loading,
      language: _language,
    ),
  );

  Future<void> fetch() async {
    final rtspUrl = await _channelRtspEndpoint.fetch();
    _amendment.value = rtspUrl;
  }
}

final class RtspUrlAmendment
  extends Amendment<ChannelRtsp?>
  with _RtspUrlFetcher
{
  RtspUrlAmendment(
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
  RtspUrlAmendment get _amendment => this;
}

final class _RtspUrlAncestor extends Ancestor<RtspUrlAmendment> {
  const _RtspUrlAncestor({
    required super.amendment,
    required super.child,
  });
}

final class RtspUrlInheritor extends Inheritor<_RtspUrlAncestor, RtspUrlAmendment, ChannelRtsp?> {
  const RtspUrlInheritor({
    super.key,
    required super.builder,
  });
}

final class RtspUrlScope extends StatefulWidget {
  const RtspUrlScope({
    super.key,
    required Widget child,
  })
  : _child = child;

  final Widget _child;

  @override
  State<RtspUrlScope> createState() => _RtspUrlScopeState();
}

class _RtspUrlScopeState extends ScopedState<RtspUrlScope, RtspUrlAmendment> {
  @override
  late final RtspUrlAmendment amendment;

  @override
  void initState() {
    super.initState();

    amendment = RtspUrlAmendment(
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
  Widget build(BuildContext context) => _RtspUrlAncestor(
    amendment: amendment,
    child: widget._child,
  );
}
