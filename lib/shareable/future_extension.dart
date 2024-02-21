// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'data/loading_data.dart';

extension FutureOrExtension<T> on Future<T> {
  Future<T> withLoadingIfExist(Loading? loading) async {
    if (loading == null) {
      return await this;
    }

    await loading.setLoading(true);
    try {
      return await this;
    } finally {
      await loading.setLoading(false);
    }
  }
}
