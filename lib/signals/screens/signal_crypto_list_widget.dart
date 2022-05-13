import 'package:tradelait/signals/screens/signal_single_screen.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/users/models/user_model.dart';
import 'package:tradelait/widgets/custom_search_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/signals/models/signal_model.dart';
import 'package:tradelait/signals/screens/signal_edit_screen.dart';
import 'package:tradelait/signals/services/signal_service.dart';

import 'package:tradelait/res/custom_colors.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';

class SignalListCrypto extends StatefulWidget {
  @override
  State<SignalListCrypto> createState() => _SignalListCryptoState();
}

class _SignalListCryptoState extends State<SignalListCrypto> {
  TextEditingController _searchController = TextEditingController();
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> signalsList = FirebaseFirestore.instance
      .collection('signals')
      .where('signalType', isEqualTo: 'Crypto')
      .snapshots();

  //
  final admin = FirebaseAuth.instance.currentUser!.email!
      .toLowerCase()
      .toString()
      .contains('admin@test.com');

  final currentUserEmail =
      FirebaseAuth.instance.currentUser!.email!.toLowerCase().toString();
  //

  var currentUser = FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> documents = [];
  String searchText = '';

  //
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then(
      (value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      },
    );
  }

  //
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
            hint: 'Search with currency pair name ',
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              //stream: SignalService().readSignals().where('signalType', isEqualTo: 'Forex'),
              stream: signalsList,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  print(snapshot.data);
                  //return Text('Something went wrong');
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData || snapshot.data != null) {
                  documents = snapshot.data!.docs;
                  if (searchText.length > 0) {
                    documents = documents.where((element) {
                      return element
                          .get('currencyPair')
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
                      var signalInfo =
                          documents[index].data() as Map<String, dynamic>;
                      String signalUid = snapshot.data!.docs[index].id;
                      String signalType = signalInfo['signalType'];
                      String currencyPair = signalInfo['currencyPair'];
                      String orderType = signalInfo['orderType'];
                      String entryPrice = signalInfo['entryPrice'];
                      String timeFrame = signalInfo['timeFrame'];
                      String takeProfit1 = signalInfo['takeProfit1'];
                      String takeProfit2 = signalInfo['takeProfit2'];
                      String takeProfit3 = signalInfo['takeProfit3'];
                      String stopLoss = signalInfo['stopLoss'];
                      String date = signalInfo['date'];
                      String createdTimeStamp = signalInfo['createdTimeStamp'];
                      String updatedTimeStamp = signalInfo['updatedTimeStamp'];

                      return Ink(
                        decoration: BoxDecoration(
                          color: Palette.firebaseGrey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          /* onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignalSingleScreen(
                                signalUid: signalUid,
                              ),
                            ),
                          ), */
                          title: Text(
                            '$entryPrice | $signalType',
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
                            '$currencyPair | $takeProfit1',
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
                            children: currentUserEmail == admin
                                ? [
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
                                      onPressed: () =>
                                          Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SignalEditScreen(
                                            signalUid: signalUid,
                                            currentSignalType: signalType,
                                            currentCurrencyPair: currencyPair,
                                            currentOrderType: orderType,
                                            currentEntryPrice: entryPrice,
                                            currentTimeFrame: timeFrame,
                                            currentTakeProfit1: takeProfit1,
                                            currentTakeProfit2: takeProfit2,
                                            currentTakeProfit3: takeProfit3,
                                            currentStopLoss: stopLoss,
                                            currentDate: date,
                                            createdTimeStamp: createdTimeStamp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                                : [],
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