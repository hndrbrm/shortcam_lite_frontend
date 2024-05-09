// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:shortcam_lite_api/shortcam_lite_api.dart';

import '../../../shareable/data/data.dart';
import '../../../shareable/data/language_data.dart';
import '../../../shareable/data/loading_data.dart';
import '../http/short_cam_lite_client.dart';

export 'package:shortcam_lite_api/shortcam_lite_api.dart' show Palette;

mixin _PaletteGetter {
  Loading? get _loading;
  PaletteAmendment get _amendment;
  Language? get _language;

  GetPaletteEndpoint get _getPaletteEndpoint => GetPaletteEndpoint(
    inner: ShortCamLiteClient(
      loading: _loading,
      language: _language,
    ),
  );

  Future<void> get() async {
    final palette = await _getPaletteEndpoint.fetch();

    _amendment.value = palette;
  }
}

mixin _PaletteSetter {
  Loading? get _loading;
  PaletteAmendment get _amendment;
  Language? get _language;

  SetPaletteEndpoint get _setPaletteEndpoint => SetPaletteEndpoint(
    inner: ShortCamLiteClient(
      loading: _loading,
      language: _language,
    ),
  );

  Future<void> set(Palette palette) async {
    await _setPaletteEndpoint.fetch(palette);
    _amendment.value = palette;
  }
}

final class PaletteAmendment
  extends Amendment<Palette?>
  with _PaletteGetter, _PaletteSetter
{
  PaletteAmendment(
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
  PaletteAmendment get _amendment => this;
}

final class _PaletteAncestor extends Ancestor<PaletteAmendment> {
  const _PaletteAncestor({
    required super.amendment,
    required super.child,
  });
}

final class PaletteInheritor extends Inheritor<_PaletteAncestor, PaletteAmendment, Palette?> {
  const PaletteInheritor({
    super.key,
    required super.builder,
  });
}

final class PaletteScope extends StatefulWidget {
  const PaletteScope({
    super.key,
    required Widget child,
  })
  : _child = child;

  final Widget _child;

  @override
  State<PaletteScope> createState() => _PaletteScopeState();
}

class _PaletteScopeState extends ScopedState<PaletteScope, PaletteAmendment> {
  @override
  late final PaletteAmendment amendment;

  @override
  void initState() {
    super.initState();

    amendment = PaletteAmendment(
      null,
      loading: LoadingAmendment.sniff(context),
      language: LanguageAmendment.sniff(context),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    amendment.get();
  }

  @override
  Widget build(BuildContext context) => _PaletteAncestor(
    amendment: amendment,
    child: widget._child,
  );
}
