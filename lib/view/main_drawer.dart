import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_find_locations/page/favorites_page.dart';
import 'package:flutter_find_locations/page/main_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(child: Text("Find Locations")),
          ),
          InkWell(
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage())
              )
            },
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.home),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Home"),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage())
              )
            },
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.favorite),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Favorites"),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}
