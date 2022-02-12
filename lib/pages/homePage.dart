import 'package:ankara_catalogue/pages/drawerPage.dart';
import 'package:ankara_catalogue/pages/tabs/Gallery.dart';
import 'package:ankara_catalogue/pages/tabs/Library.dart';
import 'package:ankara_catalogue/pages/tabs/Local.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../admob_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: DrawerPage(),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          title: Text('Ankara catalogue'),
          bottom: TabBar(
            tabs: [Text('Gallery'), Text('Library'), Text('Local Images')],
          ),
        ),
        body: TabBarView(
          children: [
            Gallery(),
            LibraryPage(),
            LocalImages(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 100,
          width: 320,
          color: Colors.deepPurple[800],
          child: AdWidget(
            key: UniqueKey(),
            ad: AdmobService.createBannerAd()..load(),
          ),
        ),
      ),
    );
  }
}