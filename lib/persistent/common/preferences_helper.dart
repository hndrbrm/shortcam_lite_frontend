// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

part of '../persistent.dart';

final class _PreferencesHelper {
  const _PreferencesHelper({
    Loading? loading,
  })
  : _loading = loading;

  final Loading? _loading;

  Future<Object?> getObject(String key) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.get(key);
  }().withLoadingIfExist(_loading);

  Future<bool?> getBool(String key) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }().withLoadingIfExist(_loading);

  Future<double?> getDouble(String key) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getDouble(key);
  }().withLoadingIfExist(_loading);

  Future<String?> getString(String key) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }().withLoadingIfExist(_loading);

  Future<List<String>?> getStringList(String key) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }().withLoadingIfExist(_loading);

  Future<int?> getInt(String key) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }().withLoadingIfExist(_loading);

  Future<void> setBool(String key, bool value) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool(key, value);
  }().withLoadingIfExist(_loading);

  Future<void> setDouble(String key, double value) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setDouble(key, value);
  }().withLoadingIfExist(_loading);

  Future<void> setString(String key, String value) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(key, value);
  }().withLoadingIfExist(_loading);

  Future<void> setStringList(String key, List<String> value) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setStringList(key, value);
  }().withLoadingIfExist(_loading);

  Future<void> setInt(String key, int value) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setInt(key, value);
  }().withLoadingIfExist(_loading);

  Future<void> removePreference(String key) async => () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove(key);
  }().withLoadingIfExist(_loading);
}
