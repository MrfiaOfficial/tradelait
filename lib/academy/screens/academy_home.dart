//import 'package:tradelait/academy/screens/academy_add_screen.dart';
//import 'package:tradelait/academy/screens/academy_list_screen.dart';
import 'package:tradelait/academy/screens/crypto_screen.dart';
import 'package:tradelait/academy/screens/forex_screen.dart';
import 'package:tradelait/academy/screens/insurance_screen.dart';
import 'package:tradelait/academy/screens/stocks_screen.dart';
import 'package:tradelait/widgets/custom_elevated_button.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class AcademyHomeScreen extends StatefulWidget {
  @override
  _AcademyHomeScreenState createState() => _AcademyHomeScreenState();
}

class _AcademyHomeScreenState extends State<AcademyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    //final brokerList = Provider.of<List<brokerData?>>(context);
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            //tooltip: 'Open shopping cart',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PrivateWrapper2()),
              );
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Academy',
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/page_images/academy.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ForexScreen()));
                },
                text: 'Forex Advocate',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CryptoScreen()));
                },
                text: 'Crypto Fuel',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => InsuranceScreen()));
                },
                text: 'Insurance Allied',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => StocksScreen()));
                },
                text: 'Stocks Hub',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
