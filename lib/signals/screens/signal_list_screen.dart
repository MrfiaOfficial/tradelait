import 'package:tradelait/signals/screens/signal_add_screen.dart';
import 'package:tradelait/signals/screens/signal_list_widget.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class SignalListScreen extends StatefulWidget {
  @override
  _SignalListScreenState createState() => _SignalListScreenState();
}

class _SignalListScreenState extends State<SignalListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Forex',
                  ),
                  Tab(
                    text: 'Crypto',
                  ),
                  Tab(
                    text: 'Stocks',
                  ),
                  Tab(
                    text: 'Others',
                  ),
                ],
              )
            ],
          ),
          /* actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              //tooltip: 'Open shopping cart',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PrivateWrapper2()),
                );
              },
            ),
          ], */
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          /* title: AppBarTitle(
            sectionName: 'Signals List',
          ), */
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'signal',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignalAddScreen(),
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
            padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
            child: TabBarView(
              children: [
                SignalList(),
                Text('Thanks'),
                Text('Thanks'),
                Text('Thanks'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
