import 'package:tradelait/assets/models/asset_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class AssetService {
  final String? uid;
  String? assetUid;

  AssetService({this.uid});

/* 
assetUid
assetName
valuePurchased
valuePresent
valueOneYear
valueFiveYears
valueTenYears
condition
purpose
assetGroup
assetType
purchasedDate
createdTimeStamp
updatedTimeStamp
credit
 */

  Future<void> addAsset({
    required String assetUid,
    required String assetName,
    String? valuePurchased,
    String? valuePresent,
    String? valueOneYear,
    String? valueFiveYears,
    String? valueTenYears,
    String? condition,
    String? purpose,
    String? assetGroup,
    String? assetType,
    String? purchasedDate,
    String? createdTimeStamp,
    String? updatedTimeStamp,
    bool? credit,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('assets').doc();

    Map<String, dynamic> data = <String, dynamic>{
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

    // await documetReferencer
    return await documentReferencer
        .set(data)
        .whenComplete(() => print("An asset added to the database"))
        .catchError((e) => print(e));
  }

  //static Future<void> updateItem({
  Future<void> updateAsset({
    required String assetUid,
    required String assetName,
    String? valuePurchased,
    String? valuePresent,
    String? valueOneYear,
    String? valueFiveYears,
    String? valueTenYears,
    String? condition,
    String? purpose,
    String? assetGroup,
    String? assetType,
    String? purchasedDate,
    String? createdTimeStamp,
    String? updatedTimeStamp,
    bool? credit,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('assets').doc(assetUid);

    Map<String, dynamic> data = <String, dynamic>{
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

    //await documentReferencer
    return await documentReferencer
        .update(data)
        .whenComplete(() => print("Asset updated successfully!"))
        .catchError((e) => print(e));
    //.then((value) async => await readPayments());
  }

  Stream<QuerySnapshot> readAssets() {
    CollectionReference assetCollection =
        _userCollection.doc(uid).collection('assets');

    return assetCollection.snapshots();
  }

  /// Get a stream of a single payment
  Stream<AssetModel> streamAsset(String assetsUid) {
    CollectionReference assetCollection =
        _userCollection.doc(uid).collection('assets');
    return assetCollection
        .doc(assetsUid)
        .snapshots()
        .map((snap) => AssetModel.fromFirestore(map: snap));
  }

  // Get Stream of Payment List
  Stream<List<AssetModel>> streamAssetsList() {
    CollectionReference assetCollection =
        _userCollection.doc(uid).collection('assets');

    return assetCollection
        .orderBy('updatedTimeStamp', descending: true)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => AssetModel.fromFirestore(map: doc))
            .toList());
  }

  Future<void> deleteAsset({
    required String assetUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('assets').doc(assetUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('An asset deleted from the database'))
        .catchError((e) => print(e));
  }
}
