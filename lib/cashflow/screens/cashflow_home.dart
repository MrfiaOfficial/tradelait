import 'package:tradelait/expenses/screens/expense_list_screen.dart';
import 'package:tradelait/widgets/custom_elevated_button.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class CashflowHomeScreen extends StatefulWidget {
  @override
  _CashflowHomeScreenState createState() => _CashflowHomeScreenState();
}

class _CashflowHomeScreenState extends State<CashflowHomeScreen> {
  @override
  Widget build(BuildContext context) {
    //final studentList = Provider.of<List<StudentData?>>(context);
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
          sectionName: 'Cashflow',
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/page_images/cashflow.png"),
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
                      builder: (context) => ExpenseListScreen()));
                },
                text: 'Expenses List',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
              /* CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ExpenseListScreen()));
                },
                text: 'List',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
