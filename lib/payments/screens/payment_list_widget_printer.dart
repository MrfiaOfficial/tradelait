import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/users/models/user_model.dart';
import 'package:tradelait/widgets/custom_search_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/payments/models/payment_model.dart';
import 'package:tradelait/payments/screens/payment_edit_screen.dart';
import 'package:tradelait/payments/screens/payment_single_screen_2.dart';
import 'package:tradelait/payments/services/payment_service.dart';

import 'package:tradelait/res/custom_colors.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';

class PaymentListPrinter extends StatefulWidget {
  @override
  State<PaymentListPrinter> createState() => _PaymentListPrinterState();
}

class _PaymentListPrinterState extends State<PaymentListPrinter> {
  TextEditingController _searchController = TextEditingController();
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  var currentUser = FirebaseAuth.instance.currentUser;
  List<PaymentModel> documents = [];
  String searchText = '';

  //
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    getPaymentSum();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then(
      (value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      },
    );
  }

  // to get the list of all students
  getPaymentSum() async {
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
  }

  // Printing settings

  // Empty Parameters for the widget to be clicked and printed
  String paymentUid = '';
  String amount = '';
  String purpose = '';
  String date = '';
  String method = '';
  String balance = '';
  String payerFirstName = '';
  String payerLastName = '';
  String payerUid = '';
  String createdDate = '';
  String updatedDate = '';
  String createdTime = '';
  String updatedTime = '';
  String timeStamp = '';
  bool credit = true;

  //
  //Printing Function
  Future<void> printTicket({
    String? paymentUid,
    String? amount,
    String? purpose,
    String? date,
    String? method,
    String? balance,
    String? payerFirstName,
    String? payerLastName,
    String? payerUid,
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
        //text: paymentInfo.amount,
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
        text: 'Student : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: (payerFirstName + ' ' + payerLastName).toString(),
        width: 8,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);

    //PaymentUid
    bytes += generator.row([
      PosColumn(
        text: 'Ref : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: paymentUid,
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
        'Note: We keep all record of payments digitally to avoid payment misunderstanding',
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
            hint: 'Search with student\'s first name ',
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
                      return element.payerFirstName
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
                                    paymentUid = paymentInfo.paymentUid;
                                    amount = paymentInfo.amount!;
                                    purpose = paymentInfo.purpose!;
                                    date = paymentInfo.date!;
                                    method = paymentInfo.method!;
                                    balance = paymentInfo.balance!;
                                    payerFirstName =
                                        paymentInfo.payerFirstName!;
                                    payerLastName = paymentInfo.payerLastName!;
                                    payerUid = paymentInfo.payerUid!;
                                    createdDate = paymentInfo.createdDate!;
                                    updatedDate = paymentInfo.updatedDate!;
                                    createdTime = paymentInfo.createdTime!;
                                    updatedTime = paymentInfo.updatedTime!;
                                    timeStamp = paymentInfo.timeStamp!;
                                    credit = paymentInfo.credit!;
                                  });

                                  await printTicket(
                                    paymentUid: paymentInfo.paymentUid,
                                    amount: paymentInfo.amount,
                                    purpose: paymentInfo.purpose,
                                    date: paymentInfo.date,
                                    method: paymentInfo.method,
                                    balance: paymentInfo.balance,
                                    payerFirstName: paymentInfo.payerFirstName,
                                    payerLastName: paymentInfo.payerLastName,
                                    payerUid: paymentInfo.payerUid,
                                    createdDate: paymentInfo.createdDate,
                                    updatedDate: paymentInfo.updatedDate,
                                    createdTime: paymentInfo.createdTime,
                                    updatedTime: paymentInfo.updatedTime,
                                    timeStamp: paymentInfo.timeStamp,
                                    credit: paymentInfo.credit,
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
