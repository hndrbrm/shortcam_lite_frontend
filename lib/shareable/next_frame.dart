// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/scheduler.dart';

typedef NextFrameCallback = FutureOr<void> Function();

final class NextFrame {
  NextFrame._();

  static Future<void> run(
    NextFrameCallback onAfterBuild, [
    Duration? timeout,
  ]) {
    const Duration defaultTimeout = Duration(seconds: 15);

    return SchedulerBinding.instance.endOfFrame.then(
      (_) => onAfterBuild(),
    )..timeout(
      timeout ?? defaultTimeout,
    );
  }
}
