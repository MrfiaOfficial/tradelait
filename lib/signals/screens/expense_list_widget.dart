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

class SignalList extends StatefulWidget {
  @override
  State<SignalList> createState() => _SignalListState();
}

class _SignalListState extends State<SignalList> {
  TextEditingController _searchController = TextEditingController();
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  var currentUser = FirebaseAuth.instance.currentUser;
  List<SignalModel> documents = [];
  String searchText = '';

  //
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    getsignalSum();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then(
      (value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      },
    );
  }

  // to get the list of all brokers
  getsignalSum() async {
    CollectionReference signalCollection =
        _userCollection.doc(currentUser!.uid).collection('signals');

    final QuerySnapshot signals = await signalCollection.get();
    final List<DocumentSnapshot> documents = signals.docs;

    num signalSum = 0;
    documents.forEach((snapshot) {
      String amount = snapshot['amount'];
      signalSum = signalSum + num.parse(amount);
    });
    //return signalSum;
    print(signalSum);
  }

  // Printing settings

  // Empty Parameters for the widget to be clicked and printed
  String signalUid = '';
  String amount = '';
  String purpose = '';
  String date = '';
  String method = '';
  String balance = '';
  String payeeBrokerName = '';
  String payeeLastName = '';
  String createdTimeStamp = '';
  String updatedTimeStamp = '';
  bool credit = true;

  //
  //Printing Function
  Future<void> printTicket({
    String? signalUid,
    String? amount,
    String? purpose,
    String? date,
    String? method,
    String? balance,
    String? payeeBrokerName,
    String? payeeLastName,
    String? createdTimeStamp,
    String? updatedTimeStamp,
    bool? credit,
  }) async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      List<int> bytes = await getTicket();
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      print("Print $result");
    } else {
      //Hadnle Not Connected Senario
      print('bluetooth not connected, can\'t print');
    }
  }

  //Receipt to be printed
  Future<List<int>> getTicket() async {
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    bytes += generator.text(
      "${loggedInUser.schoolName}",
      styles: PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
      linesAfter: 1,
    );

    bytes += generator.text(
      "${loggedInUser.houseNumber! + ', ' + loggedInUser.street! + ', ' + loggedInUser.city!}",
      //"52, Ijaiye Road, Ogba, Ikeja, Lagos, Nigeria",
      styles: PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      "${loggedInUser.state! + ', ' + loggedInUser.country!}",
      //"52, Ijaiye Road, Ogba, Ikeja, Lagos, Nigeria",
      styles: PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      "Tel: ${loggedInUser.phone}",
      //'Tel: +2349032348435',
      styles: PosStyles(align: PosAlign.center),
      linesAfter: 1,
    );

    bytes += generator.hr();

    //Amount
    bytes += generator.row([
      PosColumn(
        text: 'Amount : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        //text: signalInfo.amount,
        text: amount,
        width: 8,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);

    //Balance
    bytes += generator.row([
      PosColumn(
        text: 'Balance : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: balance,
        width: 8,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);

    // Purpose
    bytes += generator.row([
      PosColumn(
        text: 'Purpose : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: purpose,
        width: 8,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);

    //Method
    bytes += generator.row([
      PosColumn(
        text: 'Method : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: method,
        width: 8,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);

    //Date
    bytes += generator.row([
      PosColumn(
        text: 'Date : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: date,
        width: 8,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);

    //Payer's Name
    bytes += generator.row([
      PosColumn(
        text: 'broker : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: (payeeBrokerName + ' ' + payeeLastName).toString(),
        width: 8,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);

    //signalUid
    bytes += generator.row([
      PosColumn(
        text: 'Ref : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: signalUid,
        width: 8,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);

    bytes += generator.hr();

    // ticket.feed(2);
    bytes += generator.text('Thank you!',
        styles: PosStyles(align: PosAlign.center, bold: true));

    bytes += generator.text(DateTime.now().toString(),
        styles: PosStyles(align: PosAlign.center), linesAfter: 1);

    bytes += generator.text(
        'Note: We keep all record of signals digitally to avoid signal misunderstanding',
        styles: PosStyles(align: PosAlign.center, bold: false));

    bytes += generator.hr();

    bytes += generator.text(
      'Powered by tradelait',
      styles: PosStyles(
        align: PosAlign.center,
        bold: false,
      ),
    );
    bytes += generator.text(
      'www.tradelait.com',
      styles: PosStyles(
        align: PosAlign.center,
        bold: false,
      ),
    );

    bytes += generator.cut();
    return bytes;
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
            hint: 'Search with payee\'s broker name ',
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<SignalModel>>(
              stream: SignalService(uid: currentUser?.uid).streamSignalsList(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Text('Something went wrong');
                } else if (snapshot.hasData || snapshot.data != null) {
                  documents = snapshot.data!;
                  if (searchText.length > 0) {
                    documents = documents.where((element) {
                      return element.payeeBrokerName
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
                      var signalInfo = documents[index];

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
                              builder: (context) => SignalSingleScreen(
                                signalUid: signalInfo.signalUid,
                              ),
                            ),
                          ),
                          title: Text(
                            '#${signalInfo.amount} | ${signalInfo.purpose}',
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
                            '${signalInfo.payeeBrokerName} ${signalInfo.payeeLastName}',
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
                                  Icons.print,
                                  color: Palette.firebaseYellow,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    signalUid = signalInfo.signalUid;
                                    amount = signalInfo.amount!;
                                    purpose = signalInfo.purpose!;
                                    date = signalInfo.date!;
                                    method = signalInfo.method!;
                                    balance = signalInfo.balance!;
                                    payeeBrokerName =
                                        signalInfo.payeeBrokerName!;
                                    payeeLastName = signalInfo.payeeLastName!;
                                    createdTimeStamp =
                                        signalInfo.createdTimeStamp!;
                                    updatedTimeStamp =
                                        signalInfo.updatedTimeStamp!;
                                    credit = signalInfo.credit!;
                                  });

                                  await printTicket(
                                    signalUid: signalInfo.signalUid,
                                    amount: signalInfo.amount,
                                    purpose: signalInfo.purpose,
                                    date: signalInfo.date,
                                    method: signalInfo.method,
                                    balance: signalInfo.balance,
                                    payeeBrokerName: signalInfo.payeeBrokerName,
                                    payeeLastName: signalInfo.payeeLastName,
                                    createdTimeStamp:
                                        signalInfo.createdTimeStamp,
                                    updatedTimeStamp:
                                        signalInfo.updatedTimeStamp,
                                    credit: signalInfo.credit,
                                  );
                                },
                                //onPressed: connected ? this.printTicket : null,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit_outlined,
                                  color: Palette.firebaseYellow,
                                ),
                                //onPressed: () => print('delete button pressed'),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SignalEditScreen(
                                      signalUid: signalInfo.signalUid,
                                      currentAmount: signalInfo.amount ?? '',
                                      currentPurpose: signalInfo.purpose ?? '',
                                      currentDate: signalInfo.date ?? '',
                                      currentMethod: signalInfo.method ?? '',
                                      currentBalance: signalInfo.balance ?? '',
                                      currentPayeeBrokerName:
                                          signalInfo.payeeBrokerName ?? '',
                                      currentPayeeLastName:
                                          signalInfo.payeeLastName ?? '',
                                      createdTimeStamp:
                                          signalInfo.createdTimeStamp ?? '',
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
