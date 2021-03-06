import 'package:tradelait/academy/screens/academy_home.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/screens/home/home_screen.dart';
import 'package:tradelait/brokers/models/broker_model.dart';
import 'package:tradelait/brokers/services/broker_service.dart';
import 'package:tradelait/screens/more_screen.dart/more_screen.dart';
import 'package:tradelait/signals/screens/signal_list_screen.dart';
import 'package:tradelait/widgets/menu_screen.dart';
import 'package:tradelait/users/screens/user_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:tradelait/deposits/screens/deposit_list_screen.dart';
import 'package:tradelait/brokers/screens/broker_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PrivateWrapper2 extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<brokerData>>(
          initialData: [],
          create: (_) =>
              BrokerService(uid: currentUser?.uid).streamBrokersList(),
        ),
      ],
      child: WrapperWidget(),
    );
  }
}

class WrapperWidget extends StatefulWidget {
  const WrapperWidget();

  @override
  _WrapperWidgetState createState() => _WrapperWidgetState();
}

class _WrapperWidgetState extends State<WrapperWidget> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    SignalListScreen(),
    BrokerListScreen(),
    AcademyHomeScreen(),
    MoreScreen(),
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
          color: Colors.white,
        ),
        unselectedItemColor: Colors.white,
        backgroundColor: Palette.firebaseOrange,
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
            icon: Icon(Icons.money_outlined),
            label: 'Signals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Brokers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_outlined),
            label: 'Academy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
