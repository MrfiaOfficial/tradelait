import 'package:tradelait/salaries/models/salary_model.dart';
import 'package:tradelait/salaries/services/salary_service.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/salaries/screens/salary_edit_screen.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SalarySingleScreen extends StatelessWidget {
  final String salaryUid;
  SalarySingleScreen({required this.salaryUid});

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Salary Details',
        ),
      ),
      body: StreamBuilder<SalaryModel?>(
        stream: SalaryService(uid: currentUser?.uid).streamSalary(salaryUid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //return Text('screen2 ${snapshot.error.toString()}');
            //print(error);
            return Text('something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            var salary = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Palette.firebaseGrey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        bottom: 10.0,
                        top: 10.0,
                      ),
                      margin: const EdgeInsets.all(10.0),
                      /* child: Expanded(
                        child: (Text('$amount $purpose $date')),
                      ), */
                      child: Column(
                        children: [
                          SizedBox(
                            child: Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      '#${salary!.amount}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Amount paid'),
                                    leading: Icon(
                                      Icons.payment_outlined,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${salary.purpose}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Purpose of payment'),
                                    leading: Icon(
                                      Icons.card_travel_rounded,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '#${salary.balance}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text(
                                        'Balance/outstanding payment)'),
                                    leading: Icon(
                                      Icons.wallet_giftcard,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${salary.method}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Method of payment'),
                                    leading: Icon(
                                      Icons.manage_accounts_sharp,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${salary.date}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Date of payment'),
                                    leading: Icon(
                                      Icons.date_range,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${salary.staffFirstName} ${salary.staffLastName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Staff\'s name'),
                                    leading: Icon(
                                      Icons.person_outlined,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '$salaryUid',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text(
                                        'Transaction reference code'),
                                    leading: Icon(
                                      Icons.room_preferences_outlined,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Palette.firebaseWhite,
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text(
                                        'EDIT',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.firebaseNavy,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SalaryEditScreen(
                                          salaryUid: salaryUid.toString(),
                                          currentAmount:
                                              salary.amount.toString(),
                                          currentPurpose:
                                              salary.purpose.toString(),
                                          currentDate: salary.date.toString(),
                                          currentMethod:
                                              salary.method.toString(),
                                          currentBalance:
                                              salary.balance.toString(),
                                          staffFirstName:
                                              salary.staffFirstName.toString(),
                                          staffLastName:
                                              salary.staffLastName.toString(),
                                          staffUid: salary.staffUid.toString(),
                                          createdTimeStamp:
                                              salary.createdTimeStamp ?? '',
                                          credit: false,
                                          //currentSalaryUid: salaryUid,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          ;
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Palette.firebaseOrange,
              ),
            ),
          );
        },
      ),
    );
  }
}
