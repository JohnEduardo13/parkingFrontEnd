import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/tap_navigator_routes.dart';
import 'package:parking/src/services/login_state.dart';
import 'package:parking/src/ui/google_maps/maps_screen.dart';
import 'package:parking/src/ui/perfil/components/update_profile.dart';
import 'package:parking/src/ui/perfil/perfil_screen.dart';
import 'package:parking/src/ui/vehicles/vehicles_screen.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

/*class _BottomNavigationState extends State<BottomNavigation> {
  String currentPage = "Home";
  List<String> pageKeys = ["Home", "Vehiculos", "Perfil"];
  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Vehiculos": GlobalKey<NavigatorState>(),
    "Perfil": GlobalKey<NavigatorState>(),
  };

  int selectedIndex = 0;

  void onTapped(String tapItem, int index) {
    if (tapItem == currentPage) {
      navigatorKeys[tapItem]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = pageKeys[index];
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTap =
            !await navigatorKeys[currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTap) {
          if (currentPage != "Home") {
            onTapped("Home", 1);
            return false;
          }
        }
        return isFirstRouteInCurrentTap;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            buildOffStageNavigator("Home"),
            buildOffStageNavigator("Vehiculos"),
            buildOffStageNavigator("Perfil"),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kPrimaryLightColor,
          onTap: (index) {
            onTapped(pageKeys[index], index);
          },
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: kPrimaryLightColor),
                activeIcon: Icon(Icons.person, color: kPrimaryColor),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.car_rental_sharp, color: kPrimaryLightColor),
                activeIcon: Icon(Icons.person, color: kPrimaryColor),
                label: "Vehiculos"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: kPrimaryLightColor),
                activeIcon: Icon(Icons.person, color: kPrimaryColor),
                label: "Perfil"),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget buildOffStageNavigator(String tapItem) {
    return Offstage(
      offstage: currentPage != tapItem,
      child: TapNavigatorRoutes(
        navigatorKey: navigatorKeys[tapItem]!,
        tabItem: tapItem,
      ),
    );
  }
}*/

/*
class _BottomNavigationState extends State<BottomNavigation> {
  int _currentPage = 0;

  final List<Widget> _pages = [
    const MapsScreen(),
    const VehiclesScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool state = Provider.of<LoginState>(context, listen: false).isLoggedIn();
    print('Estadode logueo $state');
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kPrimaryLightColor,
        /*onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },*/
        //currentIndex: _currentPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: kPrimaryLightColor),
              activeIcon: Icon(Icons.person, color: kPrimaryColor),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.car_rental_sharp, color: kPrimaryLightColor),
              activeIcon: Icon(Icons.person, color: kPrimaryColor),
              label: "Vehiculos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: kPrimaryLightColor),
              activeIcon: Icon(Icons.person, color: kPrimaryColor),
              label: "Perfil"),
        ],
      ),
      body: Navigator(
        onGenerateRoute: (settings) {
          Widget page = const MapsScreen();
          if (settings.name == '/Map') {
            page = const MapsScreen();
            return MaterialPageRoute(builder: (context) => page);
          }
          if (settings.name == '/Map') {
            page = const VehiclesScreen();
            return MaterialPageRoute(builder: (context) => page);
          }
          if (settings.name == '/Map') {
            page = const PerfilScreen();
            return MaterialPageRoute(builder: (context) => page);
          }
          if (settings.name == '/updateProfile') {
            page = const UpdateProfile();
            return MaterialPageRoute(builder: (context) => page);
          }
        },
      ),
    );
    /*return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_currentPage],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kPrimaryLightColor,
          onTap: (index){
            setState(() {
              _currentPage = index;
            });
          },
          currentIndex: _currentPage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, color: kPrimaryLightColor), activeIcon: Icon(Icons.person, color: kPrimaryColor), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.car_rental_sharp, color: kPrimaryLightColor),activeIcon: Icon(Icons.person, color: kPrimaryColor), label: "Vehiculos"),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: kPrimaryLightColor), activeIcon: Icon(Icons.person, color: kPrimaryColor), label: "Perfil"),
          ],
        ),
      ),
    );*/
  }
}*/

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
              icon: Icon(Icons.car_rental_sharp, color: kPrimaryLightColor),
              activeIcon: Icon(Icons.car_rental_sharp, color: kPrimaryColor),
              label: "Vehiculos"),
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

/*class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> _children = [
    const MapsScreen(),
    const PerfilScreen(),
    const VehiclesScreen(),
  ];
  final Widget _page = const MapsScreen();
  int _currentIndex = 0;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      scaffold: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: kPrimaryLightColor),
                activeIcon: Icon(Icons.person, color: kPrimaryColor),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.car_rental_sharp, color: kPrimaryLightColor),
                activeIcon: Icon(Icons.person, color: kPrimaryColor),
                label: "Vehiculos"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: kPrimaryLightColor),
                activeIcon: Icon(Icons.person, color: kPrimaryColor),
                label: "Perfil"),
          ],
        ),
      ),
      children: const <Widget>[
        MapsScreen(),
        PerfilScreen(),
        VehiclesScreen(),
      ],
      onItemTap: (index) {},
    );
  }
}*/

