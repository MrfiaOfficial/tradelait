import 'package:tradelait/withdrawals/models/withdrawal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class WithdrawalService {
  //static String? uid;
  final String? uid;
  String? brokerUid;
  String? withdrawalUid;

  WithdrawalService({this.uid});

  Future<void> addWithdrawal({
    required String amount,
    required String date,
    required String method,
    required String? brokerName,
    String? brokerUid,
    String? withdrawalUid,
    String? createdDate,
    String? updatedDate,
    String? createdTime,
    String? updatedTime,
    String? timeStamp,
    bool? credit,
    //String? customWithdrawalUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('withdrawals').doc(withdrawalUid);

    Map<String, dynamic> data = <String, dynamic>{
      "amount": amount,
      "date": date,
      "method": method,
      'brokerName': brokerName,
      'brokerUid': brokerUid,
      "withdrawalUid": withdrawalUid,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'timeStamp': timeStamp,
      'credit': credit,
      //'customWithdrawalUid': customWithdrawalUid,
    };

    // await documetReferencer
    return await documentReferencer
        .set(data)
        .whenComplete(() => print("A withdrawal added to the database"))
        .catchError((e) => print(e));
  }

  //static Future<void> updateItem({
  Future<void> updateWithdrawal({
    required String amount,
    required String date,
    required String method,
    required String withdrawalUid,
    required String? brokerName,
    String? brokerUid,
    String? createdDate,
    String? updatedDate,
    String? createdTime,
    String? updatedTime,
    String? timeStamp,
    bool? credit,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('withdrawals').doc(withdrawalUid);

    Map<String, dynamic> data = <String, dynamic>{
      "amount": amount,
      "date": date,
      "method": method,
      'brokerName': brokerName,
      'brokerUid': brokerUid,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'timeStamp': timeStamp,
      'credit': credit,
    };

    //await documentReferencer
    return await documentReferencer
        .update(data)
        .whenComplete(() => print("Withdrawal updated successfully!"))
        .catchError((e) => print(e));
    //.then((value) async => await readWithdrawals());
  }

  Stream<QuerySnapshot> readWithdrawals() {
    CollectionReference withdrawalCollection =
        _userCollection.doc(uid).collection('withdrawals');

    return withdrawalCollection.snapshots();
  }

  /// Get a stream of a single withdrawals
  Stream<WithdrawalModel> streamWithdrawal(String withdrawalUid) {
    CollectionReference withdrawalCollection =
        _userCollection.doc(uid).collection('withdrawals');
    return withdrawalCollection
        .doc(withdrawalUid)
        .snapshots()
        .map((snap) => WithdrawalModel.fromFirestore(map: snap));
  }

  // Get Stream of Withdrawal List
  Stream<List<WithdrawalModel>> streamWithdrawalsList() {
    CollectionReference withdrawalCollection =
        _userCollection.doc(uid).collection('withdrawals');

    return withdrawalCollection
        .orderBy('updatedDate', descending: true)
        .orderBy('updatedTime', descending: true)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => WithdrawalModel.fromFirestore(map: doc))
            .toList());
  }

  // Get Stream of Withdrawal List for a particular broker
  Stream<List<WithdrawalModel>> streamWithdrawalsListFromBroker(
      String brokerUid) {
    CollectionReference withdrawalCollection =
        _userCollection.doc(uid).collection('withdrawals');

    return withdrawalCollection
        .where('brokerUid', isEqualTo: brokerUid)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => WithdrawalModel.fromFirestore(map: doc))
            .toList());
  }

  Future<void> deleteWithdrawal({
    required String withdrawalUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('withdrawals').doc(withdrawalUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('A withdrawals deleted from the database'))
        .catchError((e) => print(e));
  }

  // brew list from snapshot
  List<WithdrawalModel> _withdrawalListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return WithdrawalModel(
        withdrawalUid: doc['withdrawalUid'],
        amount: doc['amount'] ?? '0',
        date: doc['date'] ?? 0,
        method: doc['method'] ?? '',
        brokerName: doc['brokerName'] ?? '',
        brokerUid: doc['brokerUid'] ?? '',
        createdDate: doc['createdDate'],
        updatedDate: doc['updatedDate'],
        createdTime: doc['createdTime'],
        updatedTime: doc['updatedTime'],
      );
    }).toList();
  }

  // broker data from snapshots
  WithdrawalModel? _withdrawalSingleFromSnapshot(DocumentSnapshot snapshot) {
    var withdrawalUid;
    return WithdrawalModel(
      withdrawalUid: withdrawalUid,
      amount: snapshot['amount'],
      date: snapshot['date'],
      method: snapshot['method'],
      brokerName: snapshot['brokerName'],
      brokerUid: snapshot['brokerUid'],
      createdDate: snapshot['createdDate'],
      updatedDate: snapshot['updatedDate'],
      createdTime: snapshot['createdTime'],
      updatedTime: snapshot['updatedTime'],
    );
  }

  // get brews stream
  Stream<List<WithdrawalModel?>> get withdrawalList {
    return _userCollection
        .doc(uid)
        .collection('withdrawals')
        .snapshots()
        .map(_withdrawalListFromSnapshot);
  }

  // get user doc stream
  Stream<WithdrawalModel?> get withdrawalSingle {
    return _userCollection
        .doc(uid)
        .collection('withdrawals')
        .doc(withdrawalUid)
        .snapshots()
        .map(_withdrawalSingleFromSnapshot);
  }
}
