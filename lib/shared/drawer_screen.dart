import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/about_screen.dart';
import '../screens/age_predict_screen.dart';
import '../screens/country_universities_screen.dart';
import '../screens/gender_predict_screen.dart';
import '../screens/weather_screen.dart';
// ignore_for_file: prefer_const_constructors

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTiles = [
      'Home',
      'Gender Predict',
      'Age Predict',
      'Country Universities',
      'Weather',
      'About'
    ];

    List<Widget> menuItems = [];

    menuItems.add(
      DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Text(
          'App Tarea 6',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
    );

    for (var element in menuTiles) {
      Widget screen = Container();
      menuItems.add(ListTile(
        title: Text(
          element,
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          switch (element) {
            case 'Home':
              screen = MainApp();
              break;
            case 'Gender Predict':
              screen = GenderPredict();
              break;
            case 'Age Predict':
              screen = AgePredict();
              break;
            case 'Country Universities':
              screen = CountryUniversities();
              break;
            case 'Weather':
              screen = Weather();
              break;
            case 'About':
              screen = About();
              break;
            default:
          }
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screen));
        },
      ));
    }

    return menuItems;
  }
}
