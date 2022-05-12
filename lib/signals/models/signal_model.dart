import 'package:cloud_firestore/cloud_firestore.dart';

class SignalModel {
  String signalUid;
  String? signalType;
  String? currencyPair;
  String? orderType;
  String? entryPrice;
  String? timeFrame;
  String? takeProfit1;
  String? takeProfit2;
  String? takeProfit3;
  String? stopLoss;
  String? date;
  String? createdTimeStamp;
  String? updatedTimeStamp;

  SignalModel({
    required this.signalUid,
    this.signalType,
    this.currencyPair,
    this.orderType,
    this.entryPrice,
    this.timeFrame,
    this.takeProfit1,
    this.takeProfit2,
    this.takeProfit3,
    this.stopLoss,
    this.date,
    this.createdTimeStamp,
    this.updatedTimeStamp,
  });

  //Deserializing from Map
  factory SignalModel.fromMap(map) {
    return SignalModel(
      signalUid: map['signalUid'],
      signalType: map['signalType'],
      currencyPair: map['currencyPair'],
      orderType: map['orderType'],
      entryPrice: map['entryPrice'],
      timeFrame: map['timeFrame,'],
      takeProfit1: map['takeProfit1'],
      takeProfit2: map['takeProfit2'],
      takeProfit3: map['takeProfit3'],
      stopLoss: map['stopLoss'],
      date: map['date'],
      createdTimeStamp: map['createdDate'],
      updatedTimeStamp: map['updatedDate'],
    );
  }

  //Desirializing from Firestore
  factory SignalModel.fromFirestore({required DocumentSnapshot map}) {
    //<Map<String, dynamic>> map
    return SignalModel(
      signalUid: map.id,
      signalType: map['signalType'],
      currencyPair: map['currencyPair'],
      orderType: map['orderType'],
      entryPrice: map['entryPrice'],
      timeFrame: map['timeFrame,'],
      takeProfit1: map['takeProfit1'],
      takeProfit2: map['takeProfit2'],
      takeProfit3: map['takeProfit3'],
      stopLoss: map['stopLoss'],
      date: map['date'],
      createdTimeStamp: map['createdDate'],
      updatedTimeStamp: map['updatedDate'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'signalUid': signalUid,
      'signalType': signalType,
      'currencyPair': currencyPair,
      'orderType': orderType,
      'entryPrice': entryPrice,
      'timeFrame': timeFrame,
      'takeProfit1': takeProfit1,
      'takeProfit2': takeProfit2,
      'takeProfit3': takeProfit3,
      'stopLoss': stopLoss,
      'date': date,
      'createdTimeStamp': createdTimeStamp,
      'updatedTimeStamp': updatedTimeStamp,
    };
  }
}
