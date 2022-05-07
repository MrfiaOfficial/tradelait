import 'package:tradelait/payments/screens/unused_payments/payment_fromStudent_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class PaymentListScreenFromStudent extends StatefulWidget {
  final String studentUid;
  final String firstName;
  final String lastName;
  const PaymentListScreenFromStudent({
    Key? key,
    required this.studentUid,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);
  @override
  _PaymentListScreenFromStudentState createState() =>
      _PaymentListScreenFromStudentState();
}

class _PaymentListScreenFromStudentState
    extends State<PaymentListScreenFromStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Payments List',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: PaymentListWidgetFromStudent(
            studentUid: widget.studentUid,
            firstName: widget.firstName,
            lastName: widget.lastName,
          ),
        ),
      ),
    );
  }
}
