import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/ui/google_maps/maps_screen.dart';
import 'package:parking/src/ui/perfil/perfil_screen.dart';
import 'package:parking/src/ui/vehicles/vehicles_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: kPrimaryLightColor),
              activeIcon: Icon(Icons.home, color: kPrimaryColor),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.drive_eta, color: kPrimaryLightColor),
              activeIcon: Icon(Icons.drive_eta, color: kPrimaryColor),
              label: "Vehículos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: kPrimaryLightColor),
              activeIcon: Icon(Icons.person, color: kPrimaryColor),
              label: "Perfil"),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: MapsScreen(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: VehiclesScreen(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: PerfilScreen(),
              );
            });
          default:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: MapsScreen(),
              );
            });
        }
      },
    );
  }
}


