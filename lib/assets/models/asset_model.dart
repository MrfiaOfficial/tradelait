import 'package:cloud_firestore/cloud_firestore.dart';

class AssetModel {
  String assetUid;
  String? assetName;
  String? valuePurchased;
  String? valuePresent;
  String? valueOneYear;
  String? valueFiveYears;
  String? valueTenYears;
  String? condition;
  String? purpose;
  String? assetGroup;
  String? assetType;
  String? purchasedDate;
  String? createdTimeStamp;
  String? updatedTimeStamp;
  bool? credit;

  AssetModel({
    required this.assetUid,
    this.assetName,
    this.valuePurchased,
    this.valuePresent,
    this.valueOneYear,
    this.valueFiveYears,
    this.valueTenYears,
    this.condition,
    this.purpose,
    this.assetGroup,
    this.assetType,
    this.purchasedDate,
    this.createdTimeStamp,
    this.updatedTimeStamp,
    this.credit,
  });

  //Deserializing from Map
  factory AssetModel.fromMap(map) {
    return AssetModel(
      assetUid: map['paymentUid'],
      assetName: map['assetName'],
      valuePurchased: map['valuePurchased'],
      valuePresent: map['valuePresent'],
      valueOneYear: map['valueOneYear'],
      valueFiveYears: map['valueFiveYears'],
      valueTenYears: map['valueTenYears'],
      condition: map['condition'],
      purpose: map['purpose'],
      assetGroup: map['assetGroup'],
      assetType: map['assetType'],
      purchasedDate: map['purchasedDate'],
      createdTimeStamp: map['createdTimeStamp'],
      updatedTimeStamp: map['updatedTimeStamp'],
      credit: map['credit'],
    );
  }

  //Desirializing from Firestore
  factory AssetModel.fromFirestore({required DocumentSnapshot map}) {
    //<Map<String, dynamic>> map
    return AssetModel(
      assetUid: map.id,
      assetName: map['assetName'],
      valuePurchased: map['valuePurchased'],
      valuePresent: map['valuePresent'],
      valueOneYear: map['valueOneYear'],
      valueFiveYears: map['valueFiveYears'],
      valueTenYears: map['valueTenYears'],
      condition: map['condition'],
      purpose: map['purpose'],
      assetGroup: map['assetGroup'],
      assetType: map['assetType'],
      purchasedDate: map['purchasedDate'],
      createdTimeStamp: map['createdTimeStamp'],
      updatedTimeStamp: map['updatedTimeStamp'],
      credit: map['credit'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'assetUid': assetUid,
      'assetName': assetName,
      'valuePurchased': valuePurchased,
      'valuePresent': valuePresent,
      'valueOneYear': valueOneYear,
      'valueFiveYears': valueFiveYears,
      'valueTenYears': valueTenYears,
      'condition': condition,
      'purpose': purpose,
      'assetGroup': assetGroup,
      'assetType': assetType,
      'purchasedDate': purchasedDate,
      'createdTimeStamp': createdTimeStamp,
      'updatedTimeStamp': updatedTimeStamp,
      'credit': credit,
    };
  }
}
