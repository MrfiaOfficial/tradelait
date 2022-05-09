import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/payments/screens/payment_edit_screen.dart';
import 'package:tradelait/payments/screens/payment_single_screen_2.dart';

import 'package:tradelait/res/custom_colors.dart';

class PaymentListWidgetFrombroker extends StatefulWidget {
  final String brokerUid;
  final String brokerName;
  final String lastName;

  const PaymentListWidgetFrombroker(
      {Key? key,
      required this.brokerUid,
      required this.brokerName,
      required this.lastName})
      : super(key: key);
  @override
  State<PaymentListWidgetFrombroker> createState() =>
      _PaymentListWidgetFrombrokerstate();
}

class _PaymentListWidgetFrombrokerstate
    extends State<PaymentListWidgetFrombroker> {
  //variables
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  List allPayments = [];

  // function to generate the list of payments
  futureStuds(String brokerUid) async {
    CollectionReference paymentCollection =
        _userCollection.doc(currentUser!.uid).collection('payments');

    //final QuerySnapshot payments = (await paymentCollection.where('payerUid', isEqualTo: 'brokerUid').get) as QuerySnapshot<Object?>;

    List<DocumentSnapshot> documents = (await paymentCollection
        .where('payerUid', isEqualTo: 'brokerUid')
        .get) as List<DocumentSnapshot<Object?>>;
    /* final List<DocumentSnapshot> documents = payments.docs.where((payment) {
      return brokerUid = payment["payerUid"];
    }).toList(); */

    List paymentList = [];
    documents.forEach((snapshot) {
      paymentList.add(snapshot);
    });
    setState(() {
      allPayments = paymentList;
    });
  }

  @override
  void initState() {
    super.initState();
    futureStuds(widget.brokerUid);
    print(allPayments.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 16.0),
        itemCount: allPayments.length,
        itemBuilder: (context, index) {
          if (allPayments.length == 0) {
            return Text('No payment record is found for this broker');
          }
          var paymentInfo = allPayments[index];
          print(allPayments.length);
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
                  builder: (context) => PaymentSingleScreen2(
                    paymentUid: paymentInfo.paymentUid,
                  ),
                ),
              ),
              title: Text(
                '#${paymentInfo.amount} | ${paymentInfo.purpose}',
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
                '${paymentInfo.payerBrokerName} ${paymentInfo.payerLastName}',
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
                    style:
                        TextStyle(fontSize: 40, color: Palette.firebaseOrange),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Palette.firebaseYellow,
                    ),
                    //onPressed: () => print('delete button pressed'),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentEditScreen(
                          paymentUid: paymentInfo.paymentUid,
                          currentAmount: paymentInfo.amount ?? '',
                          currentPurpose: paymentInfo.purpose ?? '',
                          currentDate: paymentInfo.date ?? '',
                          currentMethod: paymentInfo.method ?? '',
                          currentBalance: paymentInfo.balance ?? '',
                          currentPayerBrokerName:
                              paymentInfo.payerBrokerName ?? '',
                          currentPayerLastName: paymentInfo.payerLastName ?? '',
                          currentPayerUid: paymentInfo.payerUid ?? '',
                          createdDate: paymentInfo.createdDate ?? '',
                          createdTime: paymentInfo.createdTime ?? '',
                          timeStamp: paymentInfo.timeStamp ??
                              (paymentInfo.createdDate.toString() +
                                  " " +
                                  paymentInfo.createdTime.toString()),
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
      ),
    );
  }
}
