import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/users/models/user_model.dart';
import 'package:tradelait/widgets/custom_search_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/withdrawals/models/withdrawal_model.dart';
import 'package:tradelait/withdrawals/screens/withdrawal_edit_screen.dart';
import 'package:tradelait/withdrawals/screens/withdrawal_single_screen_2.dart';
import 'package:tradelait/withdrawals/services/withdrawal_service.dart';

import 'package:tradelait/res/custom_colors.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';

class WithdrawalListPrinter extends StatefulWidget {
  @override
  State<WithdrawalListPrinter> createState() => _WithdrawalListPrinterState();
}

class _WithdrawalListPrinterState extends State<WithdrawalListPrinter> {
  TextEditingController _searchController = TextEditingController();
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  var currentUser = FirebaseAuth.instance.currentUser;
  List<WithdrawalModel> documents = [];
  String searchText = '';

  //
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    getWithdrawalSum();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then(
      (value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      },
    );
  }

  // to get the list of all brokers
  getWithdrawalSum() async {
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
  }

  // Printing settings

  // Empty Parameters for the widget to be clicked and printed
  String withdrawalUid = '';
  String amount = '';
  String date = '';
  String method = '';
  String brokerName = '';
  String brokerUid = '';
  String createdDate = '';
  String updatedDate = '';
  String createdTime = '';
  String updatedTime = '';
  String timeStamp = '';
  bool credit = true;

  //
  //Printing Function
  Future<void> printTicket({
    String? withdrawalUid,
    String? amount,
    String? date,
    String? method,
    String? brokerName,
    String? brokerUid,
    String? createdDate,
    String? updatedDate,
    String? createdTime,
    String? updatedTime,
    String? timeStamp,
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
        //text: withdrawalInfo.amount,
        text: amount,
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
        text: brokerName.toString(),
        width: 8,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);

    //WithdrawalUid
    bytes += generator.row([
      PosColumn(
        text: 'Ref : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: withdrawalUid,
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
        'Note: We keep all record of withdrawals digitally to avoid withdrawals misunderstanding',
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
                                  Icons.print,
                                  color: Palette.firebaseYellow,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    withdrawalUid =
                                        withdrawalInfo.withdrawalUid;
                                    amount = withdrawalInfo.amount!;
                                    date = withdrawalInfo.date!;
                                    method = withdrawalInfo.method!;
                                    brokerName = withdrawalInfo.brokerName!;
                                    brokerUid = withdrawalInfo.brokerUid!;
                                    createdDate = withdrawalInfo.createdDate!;
                                    updatedDate = withdrawalInfo.updatedDate!;
                                    createdTime = withdrawalInfo.createdTime!;
                                    updatedTime = withdrawalInfo.updatedTime!;
                                    timeStamp = withdrawalInfo.timeStamp!;
                                    credit = withdrawalInfo.credit!;
                                  });

                                  await printTicket(
                                    withdrawalUid: withdrawalInfo.withdrawalUid,
                                    amount: withdrawalInfo.amount,
                                    date: withdrawalInfo.date,
                                    method: withdrawalInfo.method,
                                    brokerName: withdrawalInfo.brokerName,
                                    brokerUid: withdrawalInfo.brokerUid,
                                    createdDate: withdrawalInfo.createdDate,
                                    updatedDate: withdrawalInfo.updatedDate,
                                    createdTime: withdrawalInfo.createdTime,
                                    updatedTime: withdrawalInfo.updatedTime,
                                    timeStamp: withdrawalInfo.timeStamp,
                                    credit: withdrawalInfo.credit,
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
