import 'package:ankara_catalogue/pages/homePage.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.deepPurple[800]),
      child: Drawer(
        child: ListView(
          children: [
            theAccountDrawerHeader(context),
            theListTile(context),
            Divider(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

UserAccountsDrawerHeader theAccountDrawerHeader(BuildContext context) {
  return UserAccountsDrawerHeader(
    accountName: Text('Ankara Catalogue'),
    accountEmail: Text('RyanEgbejule-jalla@gmail.com'),
    currentAccountPicture: GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.deepPurple,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Your Very own ankara catalogue'),
              content: Text(
                  'With this app, you can have your very own ankara catalogue'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('close')),
              ],
            );
          },
        );
      },
    ),
    decoration: BoxDecoration(
      color: Colors.purple[800],
    ),
  );
}

ListTile theListTile(BuildContext context) {
  return ListTile(
    title: Text(
      'Gallery',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    },
    leading: Icon(
      Icons.photo_album_sharp,
      color: Colors.white,
    ),
    trailing: Icon(
      Icons.arrow_forward_ios,
      color: Colors.white,
    ),
  );
}
