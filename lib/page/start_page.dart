// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

import '../data/loading/inherited_loading.dart';
import '../route/device_route.dart';
import '../route/home_route.dart';
import '../shareable/data/loading_data.dart';
import '../shareable/navigator_helper.dart';
import '../shareable/next_frame.dart';
import '../shareable/widget/element_event_library/element_event_library.dart';

final class StartPage extends StatelessWidget {
  const StartPage({ super.key });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: LoadingScope(
      child: Stack(
        children: <Widget>[
          _Init(
            child: Center(
              child: Image.asset('image/logo.png'),
            ),
          ),
          const InheritedLoading(),
        ],
      ),
    ),
  );
}

final class _Init extends StatelessWidget with CallbackForStatelessWidget {
  const _Init({
    required Widget child,
  })
  : _child = child;

  final Widget _child;

  @override
  void onMount(BuildContext context) {
    super.onMount(context);

    NextFrame.run(() => _init(
      loading: LoadingAmendment.sniff(context),
    ));
  }

  @override
  Widget build(BuildContext context) => _child;

  Future<void> _init({ Loading? loading }) async {
    loading?.setLoading(true);

    // Replace this dummy async, with the real one.
    await Future.delayed(const Duration(seconds: 1));

    MediaKit.ensureInitialized();

    loading?.setLoading(false);

    const HomeNavigator(navigator: navigator).root();
  }
}
