import 'package:tradelait/salaries/screens/salary_list_widget.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class SalaryListScreen extends StatefulWidget {
  @override
  _SalaryListScreenState createState() => _SalaryListScreenState();
}

class _SalaryListScreenState extends State<SalaryListScreen> {
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
          sectionName: 'Salaries List',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          //child: SalaryList2(),
          child: SalaryList(),
        ),
      ),
    );
  }
}
