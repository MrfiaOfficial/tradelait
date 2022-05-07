import 'package:tradelait/assets/screens/asset_add_screen.dart';
import 'package:tradelait/assets/screens/asset_list_widget.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class AssetListScreen extends StatefulWidget {
  @override
  _AssetListScreenState createState() => _AssetListScreenState();
}

class _AssetListScreenState extends State<AssetListScreen> {
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
          sectionName: 'Assets List',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'asset',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AssetAddScreen(),
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
          child: AssetList(),
        ),
      ),
    );
  }
}
