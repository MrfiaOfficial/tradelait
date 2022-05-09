import 'package:tradelait/payments/models/payment_model.dart';
import 'package:tradelait/payments/services/payment_service.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/payments/screens/payment_edit_screen.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class PaymentSingleScreen3 extends StatefulWidget {
  final String paymentUid;
  PaymentSingleScreen3({required this.paymentUid});
  @override
  _PaymentSingleScreen3State createState() => _PaymentSingleScreen3State();
}

class _PaymentSingleScreen3State extends State<PaymentSingleScreen3> {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Payments Details',
        ),
      ),
      body: StreamBuilder<PaymentModel>(
        stream: PaymentService(uid: currentUser?.uid)
            .streamPayment(widget.paymentUid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('screen3 ${snapshot.error.toString()}');
            //print(error);
          } else if (snapshot.hasData || snapshot.data != null) {
            var payment = snapshot.data;
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
                                      '#${payment!.amount}',
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
                                      '${payment.purpose}',
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
                                      '#${payment.balance}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle:
                                        const Text('Balance/outstanding bill)'),
                                    leading: Icon(
                                      Icons.wallet_giftcard,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${payment.method}',
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
                                      '${payment.date}',
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
                                      '${payment.payerBrokerName} ${payment.payerLastName}',
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
                                      widget.paymentUid,
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
                                        'PRINT',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.firebaseNavy,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                    //onPressed: () => print('PRINT button pressed')
                                    /* onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PrintPayment(
                                          paymentUid:
                                              widget.paymentUid.toString(),
                                          amount: payment.amount.toString(),
                                          purpose: payment.purpose.toString(),
                                          date: payment.date.toString(),
                                          method: payment.method.toString(),
                                          balance: payment.balance.toString(),
                                          payerBrokerName:
                                              payment.payerBrokerName.toString(),
                                          payerLastName:
                                              payment.payerLastName.toString(),
                                          payerUid: payment.payerUid.toString(),
                                          //currentPaymentUid: paymentUid,
                                        ),
                                      ),
                                    ), */
                                    onPressed: () =>
                                        print('Print Button Clicked'),
                                    /* onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Print7(),
                                      ),
                                    ), */
                                  ),
                                ),
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
                                        builder: (context) => PaymentEditScreen(
                                          paymentUid:
                                              widget.paymentUid.toString(),
                                          currentAmount:
                                              payment.amount.toString(),
                                          currentPurpose:
                                              payment.purpose.toString(),
                                          currentDate: payment.date.toString(),
                                          currentMethod:
                                              payment.method.toString(),
                                          currentBalance:
                                              payment.balance.toString(),
                                          currentPayerBrokerName: payment
                                              .payerBrokerName
                                              .toString(),
                                          currentPayerLastName:
                                              payment.payerLastName.toString(),
                                          currentPayerUid:
                                              payment.payerUid.toString(),
                                          createdDate:
                                              payment.createdDate.toString(),
                                          createdTime:
                                              payment.createdTime.toString(),
                                          timeStamp: payment.timeStamp ??
                                              (payment.createdDate.toString() +
                                                  " " +
                                                  payment.createdTime
                                                      .toString()),
                                          credit: payment.credit ?? true,
                                          //currentPaymentUid: paymentUid,
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
