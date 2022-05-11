import 'package:tradelait/withdrawals/models/withdrawal_model.dart';
import 'package:tradelait/withdrawals/services/withdrawal_service.dart';
import 'package:tradelait/printing/print_deposit.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/withdrawals/screens/withdrawal_edit_screen.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class WithdrawalSingleScreen2 extends StatelessWidget {
  final String withdrawalUid;
  WithdrawalSingleScreen2({required this.withdrawalUid});

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Withdrawals Details',
        ),
      ),
      body: StreamBuilder<WithdrawalModel?>(
        stream: WithdrawalService(uid: currentUser?.uid)
            .streamWithdrawal(withdrawalUid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('screen2 ${snapshot.error.toString()}');
            //print(error);
          } else if (snapshot.hasData || snapshot.data != null) {
            var withdrawals = snapshot.data;
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
                                      '${withdrawals!.amount}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Amount withdrawn'),
                                    leading: Icon(
                                      Icons.payment_outlined,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${withdrawals.method}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle:
                                        const Text('Method of withdrawal'),
                                    leading: Icon(
                                      Icons.manage_accounts_sharp,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${withdrawals.date}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Date of withdrawals'),
                                    leading: Icon(
                                      Icons.date_range,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${withdrawals.brokerName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Broker\'s name'),
                                    leading: Icon(
                                      Icons.person_outlined,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '$withdrawalUid',
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
                                        builder: (context) =>
                                            WithdrawalEditScreen(
                                          withdrawalUid:
                                              withdrawalUid.toString(),
                                          currentBrokerName:
                                              withdrawals.brokerName.toString(),
                                          currentAmount:
                                              withdrawals.amount.toString(),
                                          currentDate:
                                              withdrawals.date.toString(),
                                          currentMethod:
                                              withdrawals.method.toString(),
                                          currentBrokerUid:
                                              withdrawals.brokerUid.toString(),
                                          createdDate:
                                              withdrawals.createdDate ?? '',
                                          createdTime:
                                              withdrawals.createdTime ?? '',
                                          timeStamp: withdrawals.timeStamp ??
                                              (withdrawals.createdDate
                                                      .toString() +
                                                  " " +
                                                  withdrawals.createdTime
                                                      .toString()),
                                          credit: true,

                                          //currentWithdrawalUid: withdrawalUid,
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
