import 'package:cloud_firestore/cloud_firestore.dart';

class DepositModel {
  String depositUid;
  String? amount;
  String? date;
  String? method;
  String? brokerName;
  String? brokerUid;
  String? createdDate;
  String? updatedDate;
  String? createdTime;
  String? updatedTime;
  String? timeStamp;
  bool? credit;
  //String? customPaymentUid;

  DepositModel({
    required this.depositUid,
    this.amount,
    this.date,
    this.method,
    this.brokerName,
    this.brokerUid,
    this.createdDate,
    this.updatedDate,
    this.createdTime,
    this.updatedTime,
    this.timeStamp,
    this.credit,
    //this.customPaymentUid,
  });

  //Deserializing from Map
  factory DepositModel.fromMap(map) {
    return DepositModel(
      depositUid: map['depositUid'],
      amount: map['amount'],
      date: map['date'],
      method: map['method'],
      brokerName: map['brokerName'],
      brokerUid: map['brokerUid'],
      createdDate: map['createdDate'],
      updatedDate: map['updatedDate'],
      createdTime: map['createdTime'],
      updatedTime: map['updatedTime'],
      timeStamp: map['timeStamp'],
      credit: map['credit'],
    );
  }

  //Desirializing from Firestore
  factory DepositModel.fromFirestore({required DocumentSnapshot map}) {
    //<Map<String, dynamic>> map
    return DepositModel(
      depositUid: map.id,
      amount: map['amount'],
      date: map['date'],
      method: map['method'],
      brokerName: map['brokerName'],
      brokerUid: map['brokerUid'],
      createdDate: map['createdDate'],
      updatedDate: map['updatedDate'],
      createdTime: map['createdTime'],
      updatedTime: map['updatedTime'],
      timeStamp: map['timeStamp'],
      credit: map['credit'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'depositUid': depositUid,
      'amount': amount,
      'date': date,
      'method': method,
      'brokerName': brokerName,
      'brokerUid': brokerUid,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'timeStamp': timeStamp,
      'credit': credit,
    };
  }
}
