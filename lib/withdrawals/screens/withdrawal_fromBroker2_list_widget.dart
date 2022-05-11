import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/withdrawals/models/withdrawal_model.dart';
import 'package:tradelait/withdrawals/screens/withdrawal_edit_screen.dart';
import 'package:tradelait/withdrawals/screens/withdrawal_single_screen_2.dart';
import 'package:tradelait/withdrawals/services/withdrawal_service.dart';
import 'package:tradelait/res/custom_colors.dart';

class WithdrawalListWidgetFromBroker2 extends StatefulWidget {
  final String brokerUid;
  final String brokerName;
  const WithdrawalListWidgetFromBroker2({
    Key? key,
    required this.brokerUid,
    required this.brokerName,
  }) : super(key: key);

  @override
  State<WithdrawalListWidgetFromBroker2> createState() =>
      _WithdrawalListWidgetFromBroker2State();
}

class _WithdrawalListWidgetFromBroker2State
    extends State<WithdrawalListWidgetFromBroker2> {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder<List<WithdrawalModel>>(
      stream: WithdrawalService(uid: currentUser?.uid)
          .streamWithdrawalsListFromBroker(widget.brokerUid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var withdrawalInfo = snapshot.data![index];

              return Ink(
                decoration: BoxDecoration(
                  color: Palette.firebaseGrey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WithdrawalSingleScreen2(
                        withdrawalUid: withdrawalInfo.withdrawalUid,
                      ),
                    ),
                  ),
                  title: Text(
                    '${withdrawalInfo.amount}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      //fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  subtitle: Text(
                    '${withdrawalInfo.brokerName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      //fontSize: 24,
                      //fontWeight: FontWeight.bold,
                      color: Palette.firebaseGrey,
                      letterSpacing: 2,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '|',
                        style: TextStyle(
                            fontSize: 40, color: Palette.firebaseOrange),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Palette.firebaseYellow,
                        ),
                        //onPressed: () => print('delete button pressed'),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WithdrawalEditScreen(
                              withdrawalUid: withdrawalInfo.withdrawalUid,
                              currentAmount: withdrawalInfo.amount ?? '',
                              currentDate: withdrawalInfo.date ?? '',
                              currentMethod: withdrawalInfo.method ?? '',
                              currentBrokerName:
                                  withdrawalInfo.brokerName ?? '',
                              currentBrokerUid: withdrawalInfo.brokerUid ?? '',
                              createdDate: withdrawalInfo.createdDate ?? '',
                              createdTime: withdrawalInfo.createdTime ?? '',
                              timeStamp: withdrawalInfo.timeStamp ??
                                  (withdrawalInfo.createdDate.toString() +
                                      " " +
                                      withdrawalInfo.createdTime.toString()),
                              credit: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Palette.firebaseOrange,
            ),
          ),
        );
      },
    );
  }
}
