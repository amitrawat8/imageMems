import 'package:flutter/material.dart';
import 'package:imageflip/screen/MemesPage.dart';
import 'package:imageflip/screen/OfflinePage.dart';

import '../constant/base_key.dart';

/**
 * Created by Amit Rawat on 4/6/2022.
 */

class HomeTabPage extends StatelessWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(BaseKey.appName),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: BaseKey.memes,
              ),
              Tab(
                text: BaseKey.savedMemes,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [MemePage(), OfflinePage()],
        ),
      ),
    );
  }
}
