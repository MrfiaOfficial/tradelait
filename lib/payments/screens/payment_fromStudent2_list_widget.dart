import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/payments/models/payment_model.dart';
import 'package:tradelait/payments/screens/payment_edit_screen.dart';
import 'package:tradelait/payments/screens/payment_single_screen_2.dart';
import 'package:tradelait/payments/services/payment_service.dart';
import 'package:tradelait/res/custom_colors.dart';

class PaymentListWidgetFromStudent2 extends StatefulWidget {
  final String studentUid;
  final String firstName;
  final String lastName;
  const PaymentListWidgetFromStudent2({
    Key? key,
    required this.studentUid,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  State<PaymentListWidgetFromStudent2> createState() =>
      _PaymentListWidgetFromStudent2State();
}

class _PaymentListWidgetFromStudent2State
    extends State<PaymentListWidgetFromStudent2> {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder<List<PaymentModel>>(
      stream: PaymentService(uid: currentUser?.uid)
          .streamPaymentsListFromStudent(widget.studentUid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var paymentInfo = snapshot.data![index];

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
                    '${paymentInfo.payerFirstName} ${paymentInfo.payerLastName}',
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
                              paymentUid: paymentInfo.paymentUid,
                              currentAmount: paymentInfo.amount ?? '',
                              currentPurpose: paymentInfo.purpose ?? '',
                              currentDate: paymentInfo.date ?? '',
                              currentMethod: paymentInfo.method ?? '',
                              currentBalance: paymentInfo.balance ?? '',
                              currentPayerFirstName:
                                  paymentInfo.payerFirstName ?? '',
                              currentPayerLastName:
                                  paymentInfo.payerLastName ?? '',
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