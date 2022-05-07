import 'package:tradelait/payments/screens/payment_list_screen.dart';
import 'package:tradelait/students/screens/student_add_screen.dart';
import 'package:tradelait/students/screens/student_list_screen.dart';
import 'package:tradelait/widgets/custom_elevated_button.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class StudentHomeScreen extends StatefulWidget {
  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
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
          sectionName: 'Students & Payments',
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/page_images/students.png"),
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
                      builder: (context) => StudentListScreen()));
                },
                text: 'Students List',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StudentAddScreen()));
                },
                text: 'Add Student',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PaymentListScreen()));
                },
                text: 'Payments List',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StudentListScreen()));
                },
                text: 'Add Payment',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PaymentListScreen()));
                },
                text: 'Print Receipts',
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
