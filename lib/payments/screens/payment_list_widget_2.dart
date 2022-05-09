import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/widgets/custom_search_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/payments/models/payment_model.dart';
import 'package:tradelait/payments/screens/payment_edit_screen.dart';
import 'package:tradelait/payments/screens/payment_single_screen_2.dart';
import 'package:tradelait/payments/services/payment_service.dart';

import 'package:tradelait/res/custom_colors.dart';

class PaymentList2 extends StatefulWidget {
  @override
  State<PaymentList2> createState() => _PaymentList2State();
}

class _PaymentList2State extends State<PaymentList2> {
  TextEditingController _searchController = TextEditingController();
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  var currentUser = FirebaseAuth.instance.currentUser;
  List<PaymentModel> documents = [];
  String searchText = '';

  // to get the list of all brokers
  /* getPaymentSum() async {
    CollectionReference paymentCollection =
        _userCollection.doc(currentUser!.uid).collection('payments');

    final QuerySnapshot payments = await paymentCollection.get();
    final List<DocumentSnapshot> documents = payments.docs;

    num paymentSum = 0;
    documents.forEach((snapshot) {
      String amount = snapshot['amount'];
      paymentSum = paymentSum + num.parse(amount);
    });
    //return paymentSum;
    print(paymentSum);
  } */

  @override
  void initState() {
    //getPaymentSum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return Container(
      child: Column(
        children: <Widget>[
          CustomSearchFormField(
            isLabelEnabled: false,
            controller: _searchController,
            keyboardType: TextInputType.text,
            inputAction: TextInputAction.next,
            validator: (value) => DbValidator.validateField(
              value: value,
            ),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            label: 'Search',
            hint: 'Search with broker\'s first name ',
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<PaymentModel>>(
              stream:
                  PaymentService(uid: currentUser?.uid).streamPaymentsList(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Text('Something went wrong');
                } else if (snapshot.hasData || snapshot.data != null) {
                  documents = snapshot.data!;
                  if (searchText.length > 0) {
                    documents = documents.where((element) {
                      return element.payerBrokerName
                          .toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase());
                    }).toList();
                    /* documents.sort((a, b) {
                      return (a.updatedTime)!.compareTo(b.updatedTime!);
                    }); */
                  }
                  return ListView.separated(
                    reverse: false,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.0),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      var paymentInfo = documents[index];

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
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Palette.firebaseOrange),
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
                                      currentPayerLastName:
                                          paymentInfo.payerLastName ?? '',
                                      currentPayerUid:
                                          paymentInfo.payerUid ?? '',
                                      createdDate:
                                          paymentInfo.createdDate ?? '',
                                      createdTime:
                                          paymentInfo.createdTime ?? '',
                                      timeStamp: paymentInfo.timeStamp ??
                                          (paymentInfo.createdDate.toString() +
                                              " " +
                                              paymentInfo.createdTime
                                                  .toString()),
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
            ),
          ),
        ],
      ),
    );
  }
}
