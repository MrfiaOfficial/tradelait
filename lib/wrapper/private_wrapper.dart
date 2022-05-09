import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/menu_screen.dart';
import 'package:tradelait/users/screens/user_profile_screen.dart';
import '../screens/home/home_screen.dart';
import 'package:tradelait/payments/screens/payment_list_screen.dart';
import 'package:tradelait/brokers/screens/broker_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PrivateWrapper extends StatefulWidget {
  const PrivateWrapper();

  @override
  _PrivateWrapperState createState() => _PrivateWrapperState();
}

class _PrivateWrapperState extends State<PrivateWrapper> {
  //User? loggedInUser = FirebaseAuth.instance.currentUser;
  //late bool loggedIn;
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    //FormTypeAheadPage(),
    //brokerListScreen2(),
    brokerListScreen(),
    PaymentListScreen(),
    UserProfileScreen(),
    MenuScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pages,
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: Palette.firebaseNavy, size: 30),
        selectedItemColor: Palette.firebaseNavy,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedIconTheme: IconThemeData(
          color: Colors.black87,
        ),
        unselectedItemColor: Colors.black87,
        backgroundColor: Palette.firebaseYellow,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 10,
        iconSize: 18,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'brokers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_outlined),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_outlined),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Info',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
