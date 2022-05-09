import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/deposits/models/deposit_model.dart';
import 'package:tradelait/deposits/screens/deposit_edit_screen.dart';
import 'package:tradelait/deposits/screens/deposit_single_screen_2.dart';
import 'package:tradelait/deposits/services/deposit_service.dart';
import 'package:tradelait/res/custom_colors.dart';

class DepositListWidgetFromBroker2 extends StatefulWidget {
  final String brokerUid;
  final String brokerName;
  const DepositListWidgetFromBroker2({
    Key? key,
    required this.brokerUid,
    required this.brokerName,
  }) : super(key: key);

  @override
  State<DepositListWidgetFromBroker2> createState() =>
      _DepositListWidgetFromBroker2State();
}

class _DepositListWidgetFromBroker2State
    extends State<DepositListWidgetFromBroker2> {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder<List<DepositModel>>(
      stream: DepositService(uid: currentUser?.uid)
          .streamDepositsListFromBroker(widget.brokerUid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var depositInfo = snapshot.data![index];

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
                      builder: (context) => DepositSingleScreen2(
                        depositUid: depositInfo.depositUid,
                      ),
                    ),
                  ),
                  title: Text(
                    '#${depositInfo.amount}',
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
                    '${depositInfo.brokerName}',
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
                            builder: (context) => DepositEditScreen(
                              depositUid: depositInfo.depositUid,
                              currentAmount: depositInfo.amount ?? '',
                              currentDate: depositInfo.date ?? '',
                              currentMethod: depositInfo.method ?? '',
                              currentBrokerName: depositInfo.brokerName ?? '',
                              currentBrokerUid: depositInfo.brokerUid ?? '',
                              createdDate: depositInfo.createdDate ?? '',
                              createdTime: depositInfo.createdTime ?? '',
                              timeStamp: depositInfo.timeStamp ??
                                  (depositInfo.createdDate.toString() +
                                      " " +
                                      depositInfo.createdTime.toString()),
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
