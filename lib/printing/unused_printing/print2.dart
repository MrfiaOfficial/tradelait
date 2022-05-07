import 'dart:async';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/users/models/user_model.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class PrintPayment2 extends StatefulWidget {
  final String amount;
  final String balance;
  final String date;
  final String purpose;
  final String method;
  final String paymentUid;
  final String payerFirstName;
  final String payerLastName;

  const PrintPayment2(
      {Key? key,
      required this.amount,
      required this.balance,
      required this.date,
      required this.purpose,
      required this.method,
      required this.paymentUid,
      required this.payerFirstName,
      required this.payerLastName})
      : super(key: key);

  @override
  _PrintPayment2State createState() => _PrintPayment2State();
}

class _PrintPayment2State extends State<PrintPayment2> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late String _paymentUid;
  late String _amount;
  late String _balance;
  late String _date;
  late String _purpose;
  late String _method;
  late String _payerFirstName;
  late String _payerLastName;

  @override
  void initState() {
    super.initState();
    _paymentUid = widget.paymentUid;
    _amount = widget.amount;
    _balance = widget.balance;
    _date = widget.date;
    _purpose = widget.purpose;
    _method = widget.method;
    _payerFirstName = widget.payerFirstName;
    _payerLastName = widget.payerLastName;
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then(
      (value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      },
    );
  }

  bool connected = false;
  List availableBluetoothDevices = [];

  Future<void> getBluetooth() async {
    final List? bluetooths = await BluetoothThermalPrinter.getBluetooths;
    print("Print $bluetooths");
    setState(() {
      availableBluetoothDevices = bluetooths!;
    });
  }

  Future<void> setConnect(String mac) async {
    final String? result = await BluetoothThermalPrinter.connect(mac);
    print("state conneected $result");
    if (result == "true") {
      setState(() {
        connected = true;
      });
    } else {
      print('error');
    }
  }

  // Print Receipt

  Future<void> printTicket() async {
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

  Future<void> printGraphics() async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      List<int> bytes = await getGraphicsTicket();
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      print("Print $result");
    } else {
      //Hadnle Not Connected Senario
      print('bluetooth not connected, can\'t print');
    }
  }

  Future<List<int>> getGraphicsTicket() async {
    List<int> bytes = [];

    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);

    // Print QR Code using native function
    bytes += generator.qrcode('example.com');

    bytes += generator.hr();

    // Print Barcode using native function
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData));

    bytes += generator.cut();

    return bytes;
  }

  Future<List<int>> getTicket() async {
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    /* bytes += generator.text(
      "${loggedInUser.schoolName}",
      styles: PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
      linesAfter: 1,
    ); */

    bytes += generator.text(
      //"${loggedInUser.address}",
      "52, Ijaiye Road, Ogba, Ikeja, Lagos, Nigeria",
      styles: PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      //"${loggedInUser.phoneNumber}",
      'Tel: +2349032348435',
      styles: PosStyles(align: PosAlign.center),
      linesAfter: 1,
    );

    bytes += generator.hr();

    //Amount
    bytes += generator.row([
      PosColumn(
        text: 'Amount Paid : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: _amount,
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
        text: _balance,
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
        text: _purpose,
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
        text: _method,
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
        text: _date,
        width: 8,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);

    //Payer's Name
    bytes += generator.row([
      PosColumn(
        text: 'Payer\'s Name: ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: ({_payerFirstName + _payerLastName}).toString(),
        width: 8,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);

    //PaymentUid
    bytes += generator.row([
      PosColumn(
        text: 'Transaction Reference : ',
        width: 4,
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: _paymentUid,
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
    bytes += generator.cut();
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(
            sectionName: 'Print Receipt',
          ),
        ),
        //drawer: ArgonDrawer(currentPage: "Print Receipt"),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Search Paired Bluetooth"),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Palette.firebaseYellow,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    this.getBluetooth();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Palette.firebaseNavy,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                /* TextButton(
                  onPressed: () {
                    this.getBluetooth();
                  },
                  child: Text("Search"),
                ), */
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: availableBluetoothDevices.length > 0
                        ? availableBluetoothDevices.length
                        : 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          String select = availableBluetoothDevices[index];
                          List list = select.split("#");
                          // String name = list[0];
                          String mac = list[1];
                          this.setConnect(mac);
                        },
                        title: Text('${availableBluetoothDevices[index]}'),
                        subtitle: Text("Click to connect"),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Palette.firebaseYellow,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: connected ? this.printTicket : null,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      'Print Receipt',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Palette.firebaseNavy,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                /* TextButton(
                  onPressed: connected ? this.printGraphics : null,
                  child: Text("Print"),
                ),
                TextButton(
                  onPressed: connected ? this.printTicket : null,
                  child: Text("Print Receipt"),
                ), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
