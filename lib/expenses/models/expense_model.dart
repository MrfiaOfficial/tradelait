import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  String expenseUid;
  String? amount;
  String? purpose;
  String? date;
  String? method;
  String? balance;
  String? payeeFirstName;
  String? payeeLastName;
  String? payeeUid;
  String? createdTimeStamp;
  String? updatedTimeStamp;
  bool? credit;

  ExpenseModel({
    required this.expenseUid,
    this.amount,
    this.purpose,
    this.date,
    this.method,
    this.balance,
    this.payeeFirstName,
    this.payeeLastName,
    this.payeeUid,
    this.createdTimeStamp,
    this.updatedTimeStamp,
    this.credit,
  });

  //Deserializing from Map
  factory ExpenseModel.fromMap(map) {
    return ExpenseModel(
      expenseUid: map['expenseUid'],
      amount: map['amount'],
      purpose: map['purpose'],
      date: map['date'],
      method: map['method'],
      balance: map['balance'],
      payeeFirstName: map['payeeFirstName'],
      payeeLastName: map['payeeLastName'],
      payeeUid: map['payeeUid'],
      createdTimeStamp: map['createdDate'],
      updatedTimeStamp: map['updatedDate'],
      credit: map['credit'],
    );
  }

  //Desirializing from Firestore
  factory ExpenseModel.fromFirestore({required DocumentSnapshot map}) {
    //<Map<String, dynamic>> map
    return ExpenseModel(
      expenseUid: map.id,
      amount: map['amount'],
      purpose: map['purpose'],
      date: map['date'],
      method: map['method'],
      balance: map['balance'],
      payeeFirstName: map['payeeFirstName'],
      payeeLastName: map['payeeLastName'],
      payeeUid: map['payeeUid'],
      createdTimeStamp: map['createdTimeStamp'],
      updatedTimeStamp: map['updatedTimeStamp'],
      credit: map['credit'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'expenseUid': expenseUid,
      'amount': amount,
      'purpose': purpose,
      'date': date,
      'method': method,
      'balance': balance,
      'payeeFirstName': payeeFirstName,
      'payeeLastName': payeeLastName,
      'payeeUid': payeeUid,
      'createdTimeStamp': createdTimeStamp,
      'updatedTimeStamp': updatedTimeStamp,
      'credit': credit,
    };
  }
}
