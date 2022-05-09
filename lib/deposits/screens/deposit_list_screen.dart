import 'package:tradelait/deposits/screens/deposit_list_widget_printer.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:flutter/material.dart';
import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class DepositListScreen extends StatefulWidget {
  @override
  _DepositListScreenState createState() => _DepositListScreenState();
}

class _DepositListScreenState extends State<DepositListScreen> {
  @override
  Widget build(BuildContext context) {
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
          sectionName: 'Deposits List',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          //child: DepositList2(),
          child: DepositListPrinter(),
        ),
      ),
    );
  }
}
