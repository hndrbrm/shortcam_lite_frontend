// Copyright 2024. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

part of 'device_page_library.dart';

final class DevicePage extends StatelessWidget {
  const DevicePage({ super.key });

  @override
  Widget build(BuildContext context) => LanguageInheritor(
    builder: (languageAmendment, language) => Scaffold(
      appBar: AppBar(
        title: Text(language.openDevice),
      ),
      body: RtspUrlScope(
        child: PaletteScope(
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      PaletteInheritor(
                        builder: (paletteAmendment, palette) => OutlinedButton(
                          onPressed: () {
                            if (palette != null) {
                              paletteAmendment.set(palette.next);
                            }
                          },
                          child: Text(palette?.next.value ?? ''),
                        ),
                      ),
                    ],
                  ),
                  RtspUrlInheritor(
                    builder: (_, rtsp,) => VideoPlayer(
                      url: rtsp?.sub ?? '',
                    ),
                  ),
                ],
              ),
              const InheritedLoading(),
            ],
          ),
        ),
      ),
    ),
  );
}

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<VideoPlayer> createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();

    NativePlayer native = player.platform as NativePlayer;
    native.setProperty('profile', 'low-latency');
    native.setProperty('untimed', '');
    native.setProperty('no-cache', '');
    native.setProperty('no-demuxer-thread', '');
    native.setProperty('vd-lavc-threads', '1');
  }

  @override
  Widget build(BuildContext context) {
    player.open(Media(widget.url));

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 9.0 / 16.0,
      child: Video(controller: controller),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}

extension on Palette {
  Palette get next => switch (this) {
    Palette.rainbow => Palette.whiteHot,
    Palette.whiteHot => Palette.ironRed,
    Palette.ironRed => Palette.rainbow,
  };
}
