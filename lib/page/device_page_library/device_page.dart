// Copyright 2024. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

part of 'device_page_library.dart';

final class DevicePage extends StatelessWidget {
  const DevicePage({ super.key });

  @override
  Widget build(BuildContext context) => LanguageInheritor(
    builder: (_, language) => Scaffold(
      appBar: AppBar(
        title: Text(language.openDevice),
      ),
      body: RtspUrlScope(
        child: Stack(
          children: <Widget>[
            RtspUrlInheritor(
              builder: (_, rtsp,) => MyScreen(
                url: rtsp?.sub ?? '',
              ),
            ),
            const InheritedLoading(),
          ],
        ),
      ),
    ),
  );
}

class MyScreen extends StatefulWidget {
  const MyScreen({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<MyScreen> createState() => MyScreenState();
}

class MyScreenState extends State<MyScreen> {
  late final player = Player();
  late final controller = VideoController(player);

  @override
  Widget build(BuildContext context) {
    NativePlayer native = player.platform as NativePlayer;
    native.setProperty('profile', 'low-latency');
    native.setProperty('untimed', '');
    native.setProperty('no-cache', '');
    native.setProperty('no-demuxer-thread', '');
    native.setProperty('vd-lavc-threads', '1');

    player.open(Media(widget.url));

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
        child: Video(controller: controller),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
