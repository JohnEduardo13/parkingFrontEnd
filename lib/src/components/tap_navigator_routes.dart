import 'package:flutter/material.dart';
import 'package:parking/src/ui/add_vehicles/components/add_vehicles_form.dart';
import 'package:parking/src/ui/google_maps/maps_screen.dart';
import 'package:parking/src/ui/perfil/components/update_profile.dart';

class TapNavigatorRoutes extends StatelessWidget {
  const TapNavigatorRoutes(
      {Key? key, required this.navigatorKey, required this.tabItem})
      : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child = const MapsScreen();
    if (tabItem == "Vehículos") {
      child = const VehiclesForm();
    } else if (tabItem == "Perfil") {
      child = const UpdateProfile();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
