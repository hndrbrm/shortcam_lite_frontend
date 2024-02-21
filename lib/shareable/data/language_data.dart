// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'data.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart' show AppLocalizations;

// This interface provide the Localizations generated by
// the flutter_localizations package. Modify the Type accordingly.
// AppLocalizations is the class generated by the flutter_localizations package.
abstract interface class Language {
  AppLocalizations get language;
  set language(AppLocalizations newLanguage);
}

final class LanguageAmendment extends Amendment<AppLocalizations> implements Language {
  LanguageAmendment(super.value);

  static LanguageAmendment? sniff(BuildContext context) =>
    Amendment.sniff<LanguageAncestor, LanguageAmendment, AppLocalizations>(context);

  static LanguageAmendment? inherit(BuildContext context) =>
    Amendment.inherit<LanguageAncestor, LanguageAmendment, AppLocalizations>(context);

  @override
  AppLocalizations get language => value;

  @override
  set language(AppLocalizations newLanguage) => value = newLanguage;
}

final class LanguageAncestor extends Ancestor<LanguageAmendment> {
  const LanguageAncestor({
    super.key,
    required super.amendment,
    required super.child,
  });
}

final class LanguageSniffer extends Sniffer<LanguageAncestor, LanguageAmendment, AppLocalizations> {
  const LanguageSniffer({
    super.key,
    required super.builder,
  });
}

final class LanguageInheritor extends Inheritor<LanguageAncestor, LanguageAmendment, AppLocalizations> {
  const LanguageInheritor({
    super.key,
    required super.builder,
  });
}

final class LanguageScope extends StatefulWidget {
  const LanguageScope({
    super.key,
    required Locale defaultLocale,
    required Widget child,
  })
  : _defaultLocale = defaultLocale,
    _child = child;

  final Locale _defaultLocale;
  final Widget _child;

  @override
  State<LanguageScope> createState() => _LanguageScopeState();
}

final class _LanguageScopeState extends ScopedState<LanguageScope, LanguageAmendment> {
  @override
  late final LanguageAmendment amendment;

  AppLocalizations get defaultLanguage => lookupAppLocalizations(widget._defaultLocale);

  @override
  void initState() {
    super.initState();

    amendment = LanguageAmendment(defaultLanguage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    amendment.value = AppLocalizations.of(context) ?? defaultLanguage;
  }

  @override
  Widget build(BuildContext context) => LanguageAncestor(
    amendment: amendment,
    child: widget._child,
  );
}
