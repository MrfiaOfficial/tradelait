import 'package:tradelait/payments/screens/payment_fromStudent_add_screen.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/payments/screens/payment_fromStudent2_list_widget.dart';

import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class PaymentListScreenFromStudent2 extends StatefulWidget {
  final String studentUid;
  final String firstName;
  final String lastName;
  const PaymentListScreenFromStudent2({
    Key? key,
    required this.studentUid,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);
  @override
  _PaymentListScreenFromStudent2State createState() =>
      _PaymentListScreenFromStudent2State();
}

class _PaymentListScreenFromStudent2State
    extends State<PaymentListScreenFromStudent2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName:
              widget.firstName + ' ' + widget.lastName + ' ' + 'Payments',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'payment',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentAddScreenFromStudent(
                payerUid: widget.studentUid,
                payerFirstName: widget.firstName,
                payerLastName: widget.lastName,
              ),
            ),
          );
        },
        backgroundColor: Palette.firebaseWhite,
        child: Icon(
          Icons.add,
          color: Palette.firebaseNavy,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //drawer: ArgonDrawer(currentPage: "Payments List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: PaymentListWidgetFromStudent2(
            studentUid: widget.studentUid,
            firstName: widget.firstName,
            lastName: widget.lastName,
          ),
        ),
      ),
    );
  }
}
