import 'package:cloud_firestore/cloud_firestore.dart';

class SalaryModel {
  String salaryUid;
  String? amount;
  String? purpose;
  //String? salaryType;
  String? date;
  String? method;
  String? balance;
  String? staffFirstName;
  String? staffLastName;
  String? staffUid;
  String? createdTimeStamp;
  String? updatedTimeStamp;
  bool? credit;

  SalaryModel({
    required this.salaryUid,
    this.amount,
    this.purpose,
    //this.salaryType,
    this.date,
    this.method,
    this.balance,
    this.staffFirstName,
    this.staffLastName,
    this.staffUid,
    this.createdTimeStamp,
    this.updatedTimeStamp,
    this.credit,
  });

  //Deserializing from Map
  factory SalaryModel.fromMap(map) {
    return SalaryModel(
      salaryUid: map['salaryUid'],
      amount: map['amount'],
      purpose: map['purpose'],
      //salaryType: map['salaryType'],
      date: map['date'],
      method: map['method'],
      balance: map['balance'],
      staffFirstName: map['staffFirstName'],
      staffLastName: map['staffLastName'],
      staffUid: map['staffUid'],
      createdTimeStamp: map['createdDate'],
      updatedTimeStamp: map['updatedDate'],
      credit: map['credit'],
    );
  }

  //Desirializing from Firestore
  factory SalaryModel.fromFirestore({required DocumentSnapshot map}) {
    //<Map<String, dynamic>> map
    return SalaryModel(
      salaryUid: map.id,
      amount: map['amount'],
      purpose: map['purpose'],
      //salaryType: map['salaryType'],
      date: map['date'],
      method: map['method'],
      balance: map['balance'],
      staffFirstName: map['staffFirstName'],
      staffLastName: map['staffLastName'],
      staffUid: map['staffUid'],
      createdTimeStamp: map['createdTimeStamp'],
      updatedTimeStamp: map['updatedTimeStamp'],
      credit: map['credit'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'salaryUid': salaryUid,
      'amount': amount,
      'purpose': purpose,
      //'salaryType': salaryType,
      'date': date,
      'method': method,
      'balance': balance,
      'staffFirstName': staffFirstName,
      'staffLastName': staffLastName,
      'staffUid': staffUid,
      'createdTimeStamp': createdTimeStamp,
      'updatedTimeStamp': updatedTimeStamp,
      'credit': credit,
    };
  }
}
