// Copyright 2024. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';

import '../../shareable/data/loading_data.dart';
import '../../shareable/future_extension.dart';

export 'package:http/http.dart' show BaseRequest, StreamedResponse;

abstract base class LoadingClient with BaseClient {
  const LoadingClient({
    Client? inner,
    Loading? loading,
    Duration? timeout,
  })
  : _inner = inner,
    _loading = loading,
    _timeout = timeout ?? const Duration(seconds: 60);

  final Client? _inner;
  final Loading? _loading;
  final Duration _timeout;

  Client get __inner => _inner ?? Client();

  @override
  Future<Response> head(
    Uri url, {
    Map<String, String>? headers,
  }) => super.head(
    url,
    headers: headers,
  )
    .timeout(_timeout)
    .withLoadingIfExist(_loading);

  @override
  Future<Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) => super.get(
    url,
    headers: headers,
  )
    .timeout(_timeout)
    .withLoadingIfExist(_loading);

  @override
  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) => super.post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  )
    .timeout(_timeout)
    .withLoadingIfExist(_loading);

  @override
  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) => super.put(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  )
    .timeout(_timeout)
    .withLoadingIfExist(_loading);

  @override
  Future<Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) => super.patch(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  )
    .timeout(_timeout)
    .withLoadingIfExist(_loading);

  @override
  Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) => super.delete(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  )
    .timeout(_timeout)
    .withLoadingIfExist(_loading);

  @override
  Future<String> read(
    Uri url, {
    Map<String, String>? headers,
  }) => super.read(
    url,
    headers: headers,
  )
    .timeout(_timeout)
    .withLoadingIfExist(_loading);

  @override
  Future<Uint8List> readBytes(
    Uri url, {
    Map<String, String>? headers,
  }) => super.readBytes(
    url,
    headers: headers,
  )
    .timeout(_timeout)
    .withLoadingIfExist(_loading);

  @override
  Future<StreamedResponse> send(BaseRequest request) =>
    __inner.send(request)
      .timeout(_timeout)
      .withLoadingIfExist(_loading);
}
