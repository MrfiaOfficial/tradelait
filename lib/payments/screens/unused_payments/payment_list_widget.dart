import 'package:tradelait/payments/screens/payment_edit_screen.dart';
import 'package:tradelait/payments/screens/unused_payments/payment_single_screen.dart';
import 'package:tradelait/payments/services/payment_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../res/custom_colors.dart';
import '../../services/payment_service.dart';

class PaymentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: PaymentService(uid: currentUser?.uid).readPayments(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var paymentInfo =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String paymentUid = snapshot.data!.docs[index].id;
              String amount = paymentInfo['amount'];
              String purpose = paymentInfo['purpose'];
              String date = paymentInfo['date'];
              String method = paymentInfo['method'] ?? '';
              String balance = paymentInfo['balance'] ?? '';
              String payerFirstName = paymentInfo['payerFirstName'] ?? '';
              String payerLastName = paymentInfo['payerLastName'] ?? '';
              String payerUid = paymentInfo['payerUid'] ?? '';
              String createdDate = paymentInfo['createdDate'];
              String createdTime = paymentInfo['createdTime'];
              String timeStamp =
                  paymentInfo['timeStamp'] ?? (createdDate + " " + createdTime);
              bool credit = paymentInfo['credit'] ?? true;
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
                      builder: (context) => PaymentSingleScreen(
                        paymentUid: paymentUid,
                        amount: amount,
                        purpose: purpose,
                        date: date,
                        method: method,
                        balance: balance,
                        payerFirstName: payerFirstName,
                        payerLastName: payerLastName,
                        payerUid: payerUid,
                        //currentPaymentUid: paymentUid,
                      ),
                    ),
                  ),
                  title: Text(
                    '#$amount : $purpose',
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
                    '$payerFirstName $payerLastName',
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
                            builder: (context) => PaymentEditScreen(
                              paymentUid: paymentUid,
                              currentAmount: amount,
                              currentPurpose: purpose,
                              currentDate: date,
                              currentMethod: method,
                              currentBalance: balance,
                              currentPayerFirstName: payerFirstName,
                              currentPayerLastName: payerLastName,
                              currentPayerUid: payerUid,
                              createdDate: createdDate,
                              createdTime: createdTime,
                              timeStamp: timeStamp,
                              credit: credit,
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
