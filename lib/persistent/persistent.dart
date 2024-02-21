// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

library persistent;

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../config/theme.dart';
import '../data/photon_mode/photon_mode.dart';
import '../shareable/data/loading_data.dart';
import '../shareable/future_extension.dart';

part 'common/preferences_helper.dart';
part 'locale_persistent/locale_persistent.dart';
part 'locale_persistent/locale_preferences.dart';
part 'photon_mode_persistent/photon_mode_persistent.dart';
part 'photon_mode_persistent/photon_mode_preferences.dart';
