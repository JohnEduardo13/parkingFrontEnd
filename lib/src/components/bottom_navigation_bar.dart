import 'package:flutter/material.dart';
import 'package:parking/src/ui/google_maps/maps_screen.dart';
import 'package:parking/src/ui/perfil/perfil_screen.dart';
import 'package:parking/src/ui/vehicles/vehicles_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentPage = 0;

  final List<Widget> _pages = [
    const MapsScreen(),
    const VehiclesScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_currentPage],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            setState(() {
              _currentPage = index;
            });
          },
          currentIndex: _currentPage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.car_rental_sharp), label: "Vehicles"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          ],
        ),
      ),
    );
  }
}