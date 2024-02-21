// Copyright 2024. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../persistent/persistent.dart';
import '../shareable/data/data.dart';
import '../shareable/data/loading_data.dart';
import '../shareable/future_or_extension.dart';
import '../shareable/widget/element_event_library/element_event_library.dart';

mixin _LocaleLoader {
  LocalePersistent get _localePersistent;
  LocaleAmendment get _amendment;

  FutureOr<void> loadLocale() => _localePersistent.loadLocale()
    .then((value) => _amendment.value = value);
}

mixin _LocaleSaver {
  LocalePersistent get _localePersistent;
  LocaleAmendment get _amendment;

  FutureOr<void> saveLocale(Locale? newValue) => switch (newValue) {
    null => _localePersistent.clearLocale(),
    _ => _localePersistent.saveLocale(newValue),
  }.then(
    (_) => _amendment.value = newValue,
  );
}

final class LocaleAmendment
  extends Amendment<Locale?>
  with _LocaleLoader, _LocaleSaver
{
  LocaleAmendment(
    super.value, {
    Loading? loading,
  })
  : _localePersistent = LocalePersistent(loading: loading);

  @override
  final LocalePersistent _localePersistent;

  @override
  LocaleAmendment get _amendment => this;
}

final class LocaleAncestor extends Ancestor<LocaleAmendment> {
  const LocaleAncestor({
    super.key,
    required super.amendment,
    required super.child,
  });
}

final class LocaleSniffer extends Sniffer<LocaleAncestor, LocaleAmendment, Locale?> {
  const LocaleSniffer({
    super.key,
    required super.builder,
  });
}

final class LocaleInheritor extends Inheritor<LocaleAncestor, LocaleAmendment, Locale?> {
  const LocaleInheritor({
    super.key,
    required super.builder,
  });
}

final class LocaleInit extends StatelessWidget with CallbackForStatelessWidget {
  const LocaleInit({
    super.key,
    required LocaleAmendment amendment,
    required Widget child,
  })
  : _amendment = amendment,
    _child = child;

  final LocaleAmendment _amendment;
  final Widget _child;

  @override
  void onMount(BuildContext context) {
    super.onMount(context);
    _amendment.loadLocale();
  }

  @override
  Widget build(BuildContext context) => _child;
}

final class LocaleScope extends StatefulWidget {
  const LocaleScope({
    super.key,
    required Widget child,
  })
  : _child = child;

  final Widget _child;

  @override
  State<LocaleScope> createState() => _LocaleScopeState();
}

final class _LocaleScopeState extends ScopedState<LocaleScope, LocaleAmendment> {
  @override
  late final LocaleAmendment amendment;

  @override
  void initState() {
    super.initState();

    amendment = LocaleAmendment(
      null,
      loading: LoadingAmendment.sniff(context),
    );
  }

  @override
  Widget build(BuildContext context) => LocaleAncestor(
    amendment: amendment,
    child: LocaleInit(
      amendment: amendment,
      child: widget._child,
    ),
  );
}
