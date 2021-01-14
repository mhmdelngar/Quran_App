import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_listienning/screens/favScreen.dart';

import 'about_screen.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/quran_icon.png',
                  width: 70,
                  height: 80,
                ),
                Text('قرآ نـــي')
              ],
            ),
            decoration: BoxDecoration(color: Colors.white),
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => FavScreen(),
                ),
              );
            },
            title: Text(
              ' المفضله',
              textDirection: TextDirection.rtl,
            ),
            leading: Icon(Icons.favorite),
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => AboutScreen(),
                ),
              );
            },
            title: Text(
              'حول البرنامج',
              textDirection: TextDirection.rtl,
            ),
            leading: Icon(Icons.all_inclusive_outlined),
          ),
        ],
      ),
    );
  }
}
