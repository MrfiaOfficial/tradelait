import 'package:cloud_firestore/cloud_firestore.dart';

class SignalModel {
  String signalUid;
  String? amount;
  String? purpose;
  String? date;
  String? method;
  String? balance;
  String? payeeBrokerName;
  String? payeeLastName;
  String? payeeUid;
  String? createdTimeStamp;
  String? updatedTimeStamp;
  bool? credit;

  SignalModel({
    required this.signalUid,
    this.amount,
    this.purpose,
    this.date,
    this.method,
    this.balance,
    this.payeeBrokerName,
    this.payeeLastName,
    this.payeeUid,
    this.createdTimeStamp,
    this.updatedTimeStamp,
    this.credit,
  });

  //Deserializing from Map
  factory SignalModel.fromMap(map) {
    return SignalModel(
      signalUid: map['signalUid'],
      amount: map['amount'],
      purpose: map['purpose'],
      date: map['date'],
      method: map['method'],
      balance: map['balance'],
      payeeBrokerName: map['payeeBrokerName'],
      payeeLastName: map['payeeLastName'],
      payeeUid: map['payeeUid'],
      createdTimeStamp: map['createdDate'],
      updatedTimeStamp: map['updatedDate'],
      credit: map['credit'],
    );
  }

  //Desirializing from Firestore
  factory SignalModel.fromFirestore({required DocumentSnapshot map}) {
    //<Map<String, dynamic>> map
    return SignalModel(
      signalUid: map.id,
      amount: map['amount'],
      purpose: map['purpose'],
      date: map['date'],
      method: map['method'],
      balance: map['balance'],
      payeeBrokerName: map['payeeBrokerName'],
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
      'signalUid': signalUid,
      'amount': amount,
      'purpose': purpose,
      'date': date,
      'method': method,
      'balance': balance,
      'payeeBrokerName': payeeBrokerName,
      'payeeLastName': payeeLastName,
      'payeeUid': payeeUid,
      'createdTimeStamp': createdTimeStamp,
      'updatedTimeStamp': updatedTimeStamp,
      'credit': credit,
    };
  }
}
