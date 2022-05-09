import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  String paymentUid;
  String? amount;
  String? purpose;
  String? date;
  String? method;
  String? balance;
  String? payerBrokerName;
  String? payerLastName;
  String? payerUid;
  String? createdDate;
  String? updatedDate;
  String? createdTime;
  String? updatedTime;
  String? timeStamp;
  bool? credit;
  //String? customPaymentUid;

  PaymentModel({
    required this.paymentUid,
    this.amount,
    this.purpose,
    this.date,
    this.method,
    this.balance,
    this.payerBrokerName,
    this.payerLastName,
    this.payerUid,
    this.createdDate,
    this.updatedDate,
    this.createdTime,
    this.updatedTime,
    this.timeStamp,
    this.credit,
    //this.customPaymentUid,
  });

  //Deserializing from Map
  factory PaymentModel.fromMap(map) {
    return PaymentModel(
      paymentUid: map['paymentUid'],
      amount: map['amount'],
      purpose: map['purpose'],
      date: map['date'],
      method: map['method'],
      balance: map['balance'],
      payerBrokerName: map['payerBrokerName'],
      payerLastName: map['payerLastName'],
      payerUid: map['payerUid'],
      createdDate: map['createdDate'],
      updatedDate: map['updatedDate'],
      createdTime: map['createdTime'],
      updatedTime: map['updatedTime'],
      timeStamp: map['timeStamp'],
      credit: map['credit'],
    );
  }

  //Desirializing from Firestore
  factory PaymentModel.fromFirestore({required DocumentSnapshot map}) {
    //<Map<String, dynamic>> map
    return PaymentModel(
      paymentUid: map.id,
      amount: map['amount'],
      purpose: map['purpose'],
      date: map['date'],
      method: map['method'],
      balance: map['balance'],
      payerBrokerName: map['payerBrokerName'],
      payerLastName: map['payerLastName'],
      payerUid: map['payerUid'],
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
      'paymentUid': paymentUid,
      'amount': amount,
      'purpose': purpose,
      'date': date,
      'method': method,
      'balance': balance,
      'payerBrokerName': payerBrokerName,
      'payerLastName': payerLastName,
      'payerUid': payerUid,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'timeStamp': timeStamp,
      'credit': credit,
    };
  }
}
