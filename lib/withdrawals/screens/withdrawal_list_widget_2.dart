import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/widgets/custom_search_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/withdrawals/models/withdrawal_model.dart';
import 'package:tradelait/withdrawals/screens/withdrawal_edit_screen.dart';
import 'package:tradelait/withdrawals/screens/withdrawal_single_screen_2.dart';
import 'package:tradelait/withdrawals/services/withdrawal_service.dart';

import 'package:tradelait/res/custom_colors.dart';

class WithdrawalList2 extends StatefulWidget {
  @override
  State<WithdrawalList2> createState() => _WithdrawalList2State();
}

class _WithdrawalList2State extends State<WithdrawalList2> {
  TextEditingController _searchController = TextEditingController();
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  var currentUser = FirebaseAuth.instance.currentUser;
  List<WithdrawalModel> documents = [];
  String searchText = '';

  // to get the list of all brokers
  /* getWithdrawalSum() async {
    CollectionReference withdrawalCollection =
        _userCollection.doc(currentUser!.uid).collection('withdrawals');

    final QuerySnapshot withdrawals = await withdrawalCollection.get();
    final List<DocumentSnapshot> documents = withdrawals.docs;

    num withdrawalSum = 0;
    documents.forEach((snapshot) {
      String amount = snapshot['amount'];
      withdrawalSum = withdrawalSum + num.parse(amount);
    });
    //return withdrawalSum;
    print(withdrawalSum);
  } */

  @override
  void initState() {
    //getWithdrawalSum();
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
            hint: 'Search with broker\'s name ',
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<WithdrawalModel>>(
              stream: WithdrawalService(uid: currentUser?.uid)
                  .streamWithdrawalsList(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Text('Something went wrong');
                } else if (snapshot.hasData || snapshot.data != null) {
                  documents = snapshot.data!;
                  if (searchText.length > 0) {
                    documents = documents.where((element) {
                      return element.brokerName
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
                      var withdrawalInfo = documents[index];

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
                                    builder: (context) => WithdrawalEditScreen(
                                      withdrawalUid:
                                          withdrawalInfo.withdrawalUid,
                                      currentAmount:
                                          withdrawalInfo.amount ?? '',
                                      currentDate: withdrawalInfo.date ?? '',
                                      currentMethod:
                                          withdrawalInfo.method ?? '',
                                      currentBrokerName:
                                          withdrawalInfo.brokerName ?? '',
                                      currentBrokerUid:
                                          withdrawalInfo.brokerUid ?? '',
                                      createdDate:
                                          withdrawalInfo.createdDate ?? '',
                                      createdTime:
                                          withdrawalInfo.createdTime ?? '',
                                      timeStamp: withdrawalInfo.timeStamp ??
                                          (withdrawalInfo.createdDate
                                                  .toString() +
                                              " " +
                                              withdrawalInfo.createdTime
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
