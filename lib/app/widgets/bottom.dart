import 'package:flutter/material.dart';
import 'package:hardi_sgt/app/constant/color_app.dart';
import 'package:hardi_sgt/app/pages/home_screen.dart';
import 'package:hardi_sgt/app/pages/location_screen.dart';
import 'package:hardi_sgt/app/pages/logout_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      LocationScreen(), 
      HomeScreen(),
      LogoutScreen(),
    ];

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/image/TabBar.png',
            ), 
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            selectedItemColor: AppColor.white,
            unselectedItemColor: AppColor.black,
            backgroundColor:
                Colors.transparent, 
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), 
                label: '',
              ),
             BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
