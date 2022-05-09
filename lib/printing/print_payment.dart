import 'dart:async';
import 'package:tradelait/users/models/user_model.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PrintPayment extends StatefulWidget {
  final String amount;
  final String balance;
  final String date;
  final String purpose;
  final String method;
  final String paymentUid;
  final String payerUid;
  final String payerBrokerName;
  final String payerLastName;

  const PrintPayment(
      {Key? key,
      required this.amount,
      required this.balance,
      required this.date,
      required this.purpose,
      required this.method,
      required this.paymentUid,
      required this.payerUid,
      required this.payerBrokerName,
      required this.payerLastName})
      : super(key: key);

  @override
  _PrintPaymentState createState() => _PrintPaymentState();
}

class _PrintPaymentState extends State<PrintPayment> {
  User? currentUser = FirebaseAuth.instance.currentUser;
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

  String connectionFlag = '';
  String connectionStatus = 'Wait for Device to connect ...';
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
    print("state connected $result");
    if (result == "true") {
      setState(() {
        connected = true;
        connectionStatus = 'Device Connected! Print Now!';
        connectionFlag = '';
      });
    } else {
      print('error');
      setState(() {
        connectionFlag =
            'Unable to connect Device, \n Check your Bluetooth Connection. \n If error persists, \n close and reopen the app \n then try again';
      });
    }
  }

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
        text: widget.amount,
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
        text: widget.balance,
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
        text: widget.purpose,
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
        text: widget.method,
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
        text: widget.date,
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
        text: (widget.payerBrokerName + ' ' + widget.payerLastName).toString(),
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
        text: widget.paymentUid,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              //tooltip: 'Open shopping cart',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PrivateWrapper2()),
                );
              },
            ),
          ],
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
                  height: 20,
                ),
                // To get the state of the Blurtooth connection
                Container(
                  //color: Colors.red,
                  child: Text(
                    connectionFlag,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // To get the state of the Blurtooth connection
                Container(
                  //color: Palette.firebaseGrey,
                  child: Text(
                    connectionStatus,
                    style: TextStyle(
                      color: Palette.firebaseNavy,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
