// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

part of 'element_event_library.dart';

abstract class _UnmountCallback {
  @protected
  @mustCallSuper
  void onUnmount(BuildContext context) {}
}

abstract class _MountCallback {
  @protected
  @mustCallSuper
  void onMount(BuildContext context) {}
}

abstract class _PerformRebuildCallback {
  @protected
  @mustCallSuper
  void onPerformRebuild(BuildContext context) {}
}

mixin _UnmountEvent on Element {
  @override
  void unmount() {
    (widget as _UnmountCallback).onUnmount(this);
    super.unmount();
  }
}

mixin _MountEvent on Element {
  @override
  void mount(Element? parent, Object? newSlot) {
    (widget as _MountCallback).onMount(this);
    super.mount(parent, newSlot);
  }
}

mixin _PerformBuildEvent on Element {
  @override
  void performRebuild() {
    super.performRebuild();
    (widget as _PerformRebuildCallback).onPerformRebuild(this);
  }
}
