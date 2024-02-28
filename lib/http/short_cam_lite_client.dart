// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:bot_toast/bot_toast.dart';

import '../shareable/data/language_data.dart';
import '../shareable/http/loading_client.dart';

final class ShortCamLiteClient extends LoadingClient {
  const ShortCamLiteClient({
    super.inner,
    super.loading,
    Language? language,
  })
  : _language = language,
    super(timeout: const Duration(seconds: 3));

  final Language? _language;

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    try {
      return await super.send(request);
    } catch (e) {
      if (request.url.host == '192.168.10.19') {
        _language?.toastException();
      }
      rethrow;
    }
  }
}

extension on Language {
  void toastException() => BotToast.showText(text: language.deviceEndpointException);
}
