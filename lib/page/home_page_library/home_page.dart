// Copyright 2024. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

part of 'home_page_library.dart';

final class HomePage extends StatelessWidget {
  const HomePage({ super.key });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: RtspUrlScope(
      child: Stack(
        children: <Widget>[
          RtspUrlInheritor(
            builder: (_, rtsp,) {
              return MyScreen(
                url: rtsp?.sub ?? '',
              );
            },
          ),
          const InheritedLoading(),
        ],
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
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    player.open(Media(widget.url));

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
        child: Video(controller: controller),
      ),
    );
  }
}
