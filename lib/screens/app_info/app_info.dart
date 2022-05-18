import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoScreen extends StatefulWidget {
  @override
  _AppInfoScreenState createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          toolbarHeight: 80,
          textTheme: Theme.of(context).textTheme,
          iconTheme: Theme.of(context).iconTheme,
          title: Text("About App"),
        ),
        body: Column(
          children: [
            ListTile(
              leading: Icon(Icons.policy),
              title: Text("Privacy policy"),
              subtitle: Text("opens webpage"),
              onTap: () {
                _launchURL('https://savadub.com');
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Rate the app"),
              subtitle: Text("Leave a review for the app"),
              onTap: _review,
            ),
            ListTile(
              leading: Icon(Icons.verified),
              title: Text("App Version"),
              subtitle: Text("1.0.0"),
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded),
              title: Text("Logout"),
              //subtitle: Text("1.0.0"),
            ),
          ],
        ));
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
