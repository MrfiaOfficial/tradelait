import '../screens/app_info/app_info.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PublicWrapper extends StatefulWidget {
  //const WithTabBar({Key? key}) : super(key: key);
  const PublicWrapper();

  @override
  _PublicWrapperState createState() => _PublicWrapperState();
}

class _PublicWrapperState extends State<PublicWrapper> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    LoginScreen(),
    RegistrationScreen(),
    AppInfoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text('With TabBar Demo'),
        elevation: 0,
      ), */
      body: IndexedStack(
        children: _pages,
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.redAccent, size: 40),
        selectedItemColor: Colors.redAccent,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedIconTheme: IconThemeData(
          color: Colors.blueAccent,
        ),
        unselectedItemColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        iconSize: 20,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login_outlined),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login_rounded),
            label: 'Register',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'App Info',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
