import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/widgets/custom_search_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/deposits/models/deposit_model.dart';
import 'package:tradelait/deposits/screens/deposit_edit_screen.dart';
import 'package:tradelait/deposits/screens/deposit_single_screen_2.dart';
import 'package:tradelait/deposits/services/deposit_service.dart';

import 'package:tradelait/res/custom_colors.dart';

class DepositList2 extends StatefulWidget {
  @override
  State<DepositList2> createState() => _DepositList2State();
}

class _DepositList2State extends State<DepositList2> {
  TextEditingController _searchController = TextEditingController();
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  var currentUser = FirebaseAuth.instance.currentUser;
  List<DepositModel> documents = [];
  String searchText = '';

  // to get the list of all brokers
  /* getDepositSum() async {
    CollectionReference depositCollection =
        _userCollection.doc(currentUser!.uid).collection('deposits');

    final QuerySnapshot deposits = await depositCollection.get();
    final List<DocumentSnapshot> documents = deposits.docs;

    num depositSum = 0;
    documents.forEach((snapshot) {
      String amount = snapshot['amount'];
      depositSum = depositSum + num.parse(amount);
    });
    //return depositSum;
    print(depositSum);
  } */

  @override
  void initState() {
    //getDepositSum();
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
            hint: 'Search with broker\'s broker name ',
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<DepositModel>>(
              stream:
                  DepositService(uid: currentUser?.uid).streamDepositsList(),
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
                      var depositInfo = documents[index];

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
                                    builder: (context) => DepositEditScreen(
                                      depositUid: depositInfo.depositUid,
                                      currentAmount: depositInfo.amount ?? '',
                                      currentDate: depositInfo.date ?? '',
                                      currentMethod: depositInfo.method ?? '',
                                      currentBrokerName:
                                          depositInfo.brokerName ?? '',
                                      currentBrokerUid:
                                          depositInfo.brokerUid ?? '',
                                      createdDate:
                                          depositInfo.createdDate ?? '',
                                      createdTime:
                                          depositInfo.createdTime ?? '',
                                      timeStamp: depositInfo.timeStamp ??
                                          (depositInfo.createdDate.toString() +
                                              " " +
                                              depositInfo.createdTime
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
