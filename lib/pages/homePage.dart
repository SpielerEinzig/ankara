import 'package:ankara_catalogue/pages/drawerPage.dart';
import 'package:ankara_catalogue/pages/tabs/Gallery.dart';
import 'package:ankara_catalogue/pages/tabs/Library.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                expandedHeight: 100,
                backgroundColor: Colors.deepPurple[800],
                pinned: true,
                title: Text('Ankara fashion catalogue'),
                flexibleSpace: Container(
                  height: 70,
                  child: Text('AD comes here'),
                ),
                bottom: TabBar(
                  tabs: [
                    Text('Gallery'),
                    Text('Library'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Gallery(),
              Library(),
            ],
          ),
        ),
      ),
    );
  }
}
