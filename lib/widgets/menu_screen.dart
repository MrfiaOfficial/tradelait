import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseYellow,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Useful Info',
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            alignment: Alignment.centerLeft,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Image.asset("assets/maiskool_nobg.png"),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.policy),
            title: Text("Privacy policy"),
            subtitle: Text("opens webpage"),
            onTap: () {
              _launchURL('https://broadstreetradio.com/privacy');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.star),
            title: Text("Rate the app"),
            subtitle: Text("Leave a review for the app"),
            onTap: _review,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.verified),
            title: Text("App Version"),
            subtitle: Text("1.0.0"),
          ),
          /* DrawerTile(
            icon: Icons.home,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            iconColor: Palette.firebaseOrange,
            title: "Home",
          ),
          DrawerTile(
            icon: Icons.people,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BrokerListScreen()));
            },
            iconColor: Palette.firebaseOrange,
            title: "brokers",
          ),
          DrawerTile(
            icon: Icons.wallet_giftcard_outlined,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentListScreen()));
            },
            iconColor: Palette.firebaseOrange,
            title: "Payments",
          ),
          DrawerTile(
            icon: Icons.account_circle,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfileScreen()));
            },
            iconColor: Palette.firebaseOrange,
            title: "User Profile",
          ), */
        ],
      ),
    );
  }

  Future<void> _review() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
