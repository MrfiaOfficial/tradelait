import 'package:tradelait/students/models/student_model.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/payments/screens/unused_payments/payment_add_screen.dart';
import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  final StudentData? student;
  StudentTile({this.student});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Palette.firebaseGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onTap: () => print(' a button clicked '),
        /* onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StudentEditScreen(
              currentFirstName: student!.firstName!,
              currentLastName: student!.lastName!,
              studentUid: student!.studentUid!,
            ),
          ),
        ), */
        title: Text(
          student!.firstName!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          student!.lastName!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.add_circle_outline_outlined),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PaymentAddScreen(
                      //payerUid: student!.studentUid!,
                      //payerFirstName: student!.firstName!,
                      //payerLastName: student!.lastName!
                      ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined),
              onPressed: () => print('a button is clicked'),
              /* onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StudentEditScreen(
                    currentFirstName: student!.firstName!,
                    currentLastName: student!.firstName!,
                    studentUid: student!.studentUid!,
                  ),
                ),
              ), */
            ),
            IconButton(
              icon: Icon(Icons.delete_rounded),
              onPressed: () => print('delete button pressed'),
            ),
          ],
        ),
      ),
    );
  }
}
