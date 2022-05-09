import 'package:tradelait/brokers/screens/broker_list_widget.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

import 'broker_add_screen.dart';

class brokerListScreen extends StatefulWidget {
  @override
  _brokerListScreenState createState() => _brokerListScreenState();
}

class _brokerListScreenState extends State<brokerListScreen> {
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
          sectionName: 'Broker List',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'broker',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => brokerAddScreen(),
            ),
          );
        },
        backgroundColor: Palette.firebaseWhite,
        child: Icon(
          Icons.add,
          color: Palette.firebaseNavy,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: BrokerList(),
        ),
      ),
    );
  }
}
