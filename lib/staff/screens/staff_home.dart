import 'package:tradelait/salaries/screens/salary_list_screen.dart';
import 'package:tradelait/staff/screens/staff_add_screen.dart';
import 'package:tradelait/staff/screens/staff_list_screen.dart';
import 'package:tradelait/widgets/custom_elevated_button.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class StaffHomeScreen extends StatefulWidget {
  @override
  _StaffHomeScreenState createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
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
          sectionName: 'Staff & Salaries',
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/page_images/staff.png"),
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
                      builder: (context) => StaffListScreen()));
                },
                text: 'Staff List',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StaffAddScreen()));
                },
                text: 'Add Staff',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SalaryListScreen()));
                },
                text: 'Salaries List',
                bgColor: Palette.firebaseWhite,
                textColor: Palette.firebaseNavy,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StaffListScreen()));
                },
                text: 'Record Salary',
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
