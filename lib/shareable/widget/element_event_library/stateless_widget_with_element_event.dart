// Copyright 2023. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

part of 'element_event_library.dart';

class _StatelessElementWithEvent<W extends StatelessWidget>
  extends StatelessElement
  with _MountEvent, _UnmountEvent, _PerformBuildEvent
{
  _StatelessElementWithEvent(W super.widget);
}

/// Add event handler on the stateless element, such as onMount, onUnmount, etc.
///
/// Do not use this to store any field or state, because the field/state
/// might change on every widget rebuild.
/// Use [State] class for that purposes instead.
///
/// The purposes of this mixin is to call some method in the event.
mixin CallbackForStatelessWidget
  on StatelessWidget
  implements _MountCallback, _UnmountCallback, _PerformRebuildCallback
{
  @override
  void onMount(BuildContext context) {}

  @override
  StatelessElement createElement() => _StatelessElementWithEvent(this);

  @override
  void onPerformRebuild(BuildContext context) {}

  @override
  void onUnmount(BuildContext context) {}
}
