import 'package:tradelait/printing/printer_setting.dart';
import 'package:tradelait/widgets/custom_elevated_button.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class InvoicingHomeScreen extends StatefulWidget {
  @override
  _InvoicingHomeScreenState createState() => _InvoicingHomeScreenState();
}

class _InvoicingHomeScreenState extends State<InvoicingHomeScreen> {
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
          sectionName: 'Invoicing',
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/page_images/invoicing.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PrinterSettingScreen()));
                },
                text: 'Printer Settings',
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
