import 'package:tradelait/printing/print_payment.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/payments/screens/payment_edit_screen.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

import 'package:flutter/material.dart';

class PaymentSingleScreen extends StatelessWidget {
  //final PaymentModel? payment;
  final String? amount;
  final String? purpose;
  final String? date;
  final String? method;
  final String? balance;
  final String? payerBrokerName;
  final String? payerLastName;
  final String? paymentUid;
  final String? payerUid;
  final String? createdDate;
  final String? createdTime;
  final String? timeStamp;
  final bool? credit;
  PaymentSingleScreen({
    this.amount,
    this.purpose,
    this.date,
    this.method,
    this.balance,
    this.payerBrokerName,
    this.payerLastName,
    this.paymentUid,
    this.payerUid,
    this.createdDate,
    this.createdTime,
    this.timeStamp,
    this.credit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Payments Details',
        ),
      ),
      //drawer: ArgonDrawer(currentPage: "Payments List"),
      body: SingleChildScrollView(
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
                                '#$amount',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: const Text('Amount paid'),
                              leading: Icon(
                                Icons.payment_outlined,
                                color: Colors.grey[500],
                              ),
                            ),
                            ListTile(
                              title: Text(
                                '$purpose',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: const Text('Purpose of payment'),
                              leading: Icon(
                                Icons.card_travel_rounded,
                                color: Colors.grey[500],
                              ),
                            ),
                            ListTile(
                              title: Text(
                                '#$balance',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: const Text('Balance/outstanding bill)'),
                              leading: Icon(
                                Icons.wallet_giftcard,
                                color: Colors.grey[500],
                              ),
                            ),
                            ListTile(
                              title: Text(
                                '$method',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: const Text('Method of payment'),
                              leading: Icon(
                                Icons.manage_accounts_sharp,
                                color: Colors.grey[500],
                              ),
                            ),
                            ListTile(
                              title: Text(
                                '$date',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: const Text('Date of payment'),
                              leading: Icon(
                                Icons.date_range,
                                color: Colors.grey[500],
                              ),
                            ),
                            ListTile(
                              title: Text(
                                '$payerBrokerName $payerLastName',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: const Text('Payer\'s name'),
                              leading: Icon(
                                Icons.person_outlined,
                                color: Colors.grey[500],
                              ),
                            ),
                            ListTile(
                              title: Text(
                                '$paymentUid',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle:
                                  const Text('Transaction reference code'),
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
                                backgroundColor: MaterialStateProperty.all(
                                  Palette.firebaseWhite,
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PrintPayment(
                                    paymentUid: paymentUid.toString(),
                                    amount: amount.toString(),
                                    purpose: purpose.toString(),
                                    date: date.toString(),
                                    method: method.toString(),
                                    balance: balance.toString(),
                                    payerBrokerName: payerBrokerName.toString(),
                                    payerLastName: payerLastName.toString(),
                                    payerUid: payerUid.toString(),
                                    //currentPaymentUid: paymentUid,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30.0),
                          Container(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Palette.firebaseWhite,
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                    paymentUid: paymentUid.toString(),
                                    currentAmount: amount.toString(),
                                    currentPurpose: purpose.toString(),
                                    currentDate: date.toString(),
                                    currentMethod: method.toString(),
                                    currentBalance: balance.toString(),
                                    currentPayerBrokerName:
                                        payerBrokerName.toString(),
                                    currentPayerLastName:
                                        payerLastName.toString(),
                                    currentPayerUid: payerUid.toString(),
                                    createdDate: createdDate.toString(),
                                    createdTime: createdTime.toString(),
                                    timeStamp: timeStamp ??
                                        (createdDate.toString() +
                                            " " +
                                            createdTime.toString()),
                                    credit: credit ?? true,
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
      ),
    );
  }
}
