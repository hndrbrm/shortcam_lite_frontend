// Copyright 2024. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shortcam_lite_frontend/route/device_info_route.dart';
import 'package:shortcam_lite_frontend/route/home_route.dart';

import 'config/locale.dart';
import 'data/locale_data.dart';
import 'data/photon_mode/photon_mode_data.dart';
import 'page/start_page.dart';
import 'route/device_route.dart';
import 'route/under_construction_route.dart';
import 'shareable/data/language_data.dart';
import 'shareable/data/loading_data.dart';
import 'shareable/desktop_also_scroll.dart';
import 'shareable/navigator_helper.dart';
import 'shareable/route/generate_route.dart';
import 'shareable/route/page_builder_generator.dart';
import 'shareable/route/unknown_route.dart';
import 'shareable/stylus_also_scroll.dart';
import 'shareable/widget/proxy_widget.dart';
import 'shareable/widget/tv_can_click.dart';
import 'singular_theme.dart';

final class SingularApp extends StatelessWidget {
  const SingularApp({ super.key });

  @override
  Widget build(BuildContext context) => TvCanClick(
    child: _Scope(
      child: LocaleInheritor(
        builder: (_, Locale? locale) => PhotonModeInheritor(
          builder: (PhotonModeAmendment photonMode, __) => ObjectProxy(
            object: (_, __, Widget page) => LanguageScope(
              defaultLocale: LocaleConfig.defaultLocale,
              child: page,
            ),
            builder: (_, PageBuilderProxy pageBuilderProxy) => MaterialApp(
              navigatorKey: navigator.key,
              onGenerateRoute: GenerateRouteHandler(
                pageBuilderProxy: pageBuilderProxy,
                builders: <PageGenerator>[
                  const DeviceRoute(),
                  const DeviceInfoRoute(),
                  const HomeRoute(),
                  const UnderConstructionRoute(),
                ],
              ).handleGenerateRoute,
              onUnknownRoute: UnknownRouteHandler(
                pageBuilderProxy: pageBuilderProxy,
                page: const StartPage(),
              ).handleUnknownRoute,
              navigatorObservers: <NavigatorObserver>[ BotToastNavigatorObserver() ],
              builder: BotToastInit(),
              theme: SingularThemeData.light(),
              darkTheme: SingularThemeData.dark(),
              themeMode: photonMode.toThemeMode(),
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              scrollBehavior: const _ScrollBehavior(),
            ),
          ),
        ),
      ),
    ),
  );
}

final class _Scope extends StatelessWidget {
  const _Scope({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => LoadingScope(
    child: LocaleScope(
      child: PhotonModeScope(
        child: child,
      ),
    ),
  );
}

class _ScrollBehavior extends MaterialScrollBehavior {
  const _ScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    ...super.dragDevices,
    ...const DesktopAlsoScroll().dragDevices,
    ...const StylusAlsoScroll().dragDevices,
  };
}
