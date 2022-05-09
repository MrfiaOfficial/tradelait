import 'package:tradelait/deposits/models/deposit_model.dart';
import 'package:tradelait/deposits/services/deposit_service.dart';
import 'package:tradelait/printing/print_deposit.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/deposits/screens/deposit_edit_screen.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class DepositSingleScreen2 extends StatelessWidget {
  final String depositUid;
  DepositSingleScreen2({required this.depositUid});

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Deposits Details',
        ),
      ),
      body: StreamBuilder<DepositModel?>(
        stream: DepositService(uid: currentUser?.uid).streamDeposit(depositUid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('screen2 ${snapshot.error.toString()}');
            //print(error);
          } else if (snapshot.hasData || snapshot.data != null) {
            var deposit = snapshot.data;
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
                                      '#${deposit!.amount}',
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
                                      '${deposit.method}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Method of deposit'),
                                    leading: Icon(
                                      Icons.manage_accounts_sharp,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${deposit.date}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Date of deposit'),
                                    leading: Icon(
                                      Icons.date_range,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${deposit.brokerName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Payer\'s name'),
                                    leading: Icon(
                                      Icons.person_outlined,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '$depositUid',
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
                                SizedBox(width: 30.0),
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
                                        builder: (context) => DepositEditScreen(
                                          depositUid: depositUid.toString(),
                                          currentBrokerName:
                                              deposit.brokerName.toString(),
                                          currentAmount:
                                              deposit.amount.toString(),
                                          currentDate: deposit.date.toString(),
                                          currentMethod:
                                              deposit.method.toString(),
                                          currentBrokerUid:
                                              deposit.brokerUid.toString(),
                                          createdDate:
                                              deposit.createdDate ?? '',
                                          createdTime:
                                              deposit.createdTime ?? '',
                                          timeStamp: deposit.timeStamp ??
                                              (deposit.createdDate.toString() +
                                                  " " +
                                                  deposit.createdTime
                                                      .toString()),
                                          credit: true,

                                          //currentDepositUid: depositUid,
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
