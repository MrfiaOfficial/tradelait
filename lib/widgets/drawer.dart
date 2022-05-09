import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/deposits/screens/deposit_list_screen.dart';
import 'package:tradelait/brokers/screens/broker_list_screen.dart';
import 'package:tradelait/users/screens/user_profile_screen.dart';
import '../screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '/constants/Theme.dart';

import '/widgets/drawer-tile.dart';

class ArgonDrawer extends StatelessWidget {
  final String? currentPage;

  ArgonDrawer({this.currentPage});

  _launchURL() async {
    const url = 'https://savadub.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      //color: ArgonColors.white,
      color: Palette.firebaseYellow,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Image.asset("assets/maiskool_nobg.png"),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home")
                      //Navigator.pushReplacementNamed(context, '/home');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                  },
                  iconColor: Palette.firebaseOrange,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.people,
                  onTap: () {
                    if (currentPage != "brokers")
                      //Navigator.pushReplacementNamed(context, '/home');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => brokerListScreen()));
                  },
                  iconColor: Palette.firebaseOrange,
                  title: "brokers",
                  isSelected: currentPage == "brokers" ? true : false),

              DrawerTile(
                  icon: Icons.wallet_giftcard_outlined,
                  onTap: () {
                    if (currentPage != "Payments")
                      //Navigator.pushReplacementNamed(context, '/home');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DepositListScreen()));
                  },
                  iconColor: Palette.firebaseOrange,
                  title: "Payments",
                  isSelected: currentPage == "Payments" ? true : false),

              DrawerTile(
                  icon: Icons.account_circle,
                  onTap: () {
                    if (currentPage != "User Profile")
                      //Navigator.pushReplacementNamed(context, '/home');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileScreen()));
                  },
                  iconColor: Palette.firebaseOrange,
                  title: "User Profile",
                  isSelected: currentPage == "User Profile" ? true : false),

              // second broker list screen
              /* DrawerTile(
                icon: Icons.people,
                onTap: () {
                  if (currentPage != "brokers 2")
                    //Navigator.pushReplacementNamed(context, '/home');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => brokerListScreen2()));
                },
                iconColor: ArgonColors.primary,
                title: "brokers 2",
                isSelected: currentPage == "brokers 2" ? true : false,
              ), */
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("VIDEO GUIDES",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                      icon: Icons.airplanemode_active,
                      onTap: _launchURL,
                      iconColor: ArgonColors.muted,
                      title: "Getting Started",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }
}
