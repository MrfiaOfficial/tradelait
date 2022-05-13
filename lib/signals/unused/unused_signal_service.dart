import 'package:tradelait/signals/models/signal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class SignalService {
  final String? uid;
  String? signalUid;

  SignalService({this.uid});

  Future<void> addSignal({
    String? signalUid,
    String? signalType,
    String? currencyPair,
    String? orderType,
    String? entryPrice,
    String? timeFrame,
    String? takeProfit1,
    String? takeProfit2,
    String? takeProfit3,
    String? stopLoss,
    String? date,
    String? createdTimeStamp,
    String? updatedTimeStamp,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('signals').doc();

    Map<String, dynamic> data = <String, dynamic>{
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

    // await documetReferencer
    return await documentReferencer
        .set(data)
        .whenComplete(() => print("An signal added to the database"))
        .catchError((e) => print(e));
  }

  //static Future<void> updateItem({
  Future<void> updateSignal({
    String? signalUid,
    String? signalType,
    String? currencyPair,
    String? orderType,
    String? entryPrice,
    String? timeFrame,
    String? takeProfit1,
    String? takeProfit2,
    String? takeProfit3,
    String? stopLoss,
    String? date,
    String? createdTimeStamp,
    String? updatedTimeStamp,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('signals').doc(signalUid);

    Map<String, dynamic> data = <String, dynamic>{
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

    //await documentReferencer
    return await documentReferencer
        .update(data)
        .whenComplete(() => print("Signal updated successfully!"))
        .catchError((e) => print(e));
    //.then((value) async => await readPayments());
  }

  Stream<QuerySnapshot> readSignals() {
    CollectionReference signalCollection =
        _userCollection.doc(uid).collection('signals');

    return signalCollection.snapshots();
  }

  /// Get a stream of a single payment
  Stream<SignalModel> streamSignal(String signalsUid) {
    CollectionReference signalCollection =
        _userCollection.doc(uid).collection('signals');
    return signalCollection
        .doc(signalsUid)
        .snapshots()
        .map((snap) => SignalModel.fromFirestore(map: snap));
  }

  // Get Stream of Payment List
  Stream<List<SignalModel>> streamSignalsList() {
    CollectionReference signalCollection =
        _userCollection.doc(uid).collection('signals');

    return signalCollection
        .orderBy('updatedTimeStamp', descending: true)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => SignalModel.fromFirestore(map: doc))
            .toList());
  }

  Future<void> deleteSignal({
    required String signalUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('signals').doc(signalUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('An signal deleted from the database'))
        .catchError((e) => print(e));
  }
}
