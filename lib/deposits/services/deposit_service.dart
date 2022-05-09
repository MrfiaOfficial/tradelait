import 'package:tradelait/deposits/models/deposit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class DepositService {
  //static String? uid;
  final String? uid;
  String? brokerUid;
  String? depositUid;

  DepositService({this.uid});

  Future<void> addDeposit({
    required String amount,
    required String date,
    required String method,
    required String? brokerName,
    String? brokerUid,
    String? depositUid,
    String? createdDate,
    String? updatedDate,
    String? createdTime,
    String? updatedTime,
    String? timeStamp,
    bool? credit,
    //String? customDepositUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('deposits').doc(depositUid);

    Map<String, dynamic> data = <String, dynamic>{
      "amount": amount,
      "date": date,
      "method": method,
      'brokerName': brokerName,
      'brokerUid': brokerUid,
      "depositUid": depositUid,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'timeStamp': timeStamp,
      'credit': credit,
      //'customDepositUid': customDepositUid,
    };

    // await documetReferencer
    return await documentReferencer
        .set(data)
        .whenComplete(() => print("A deposit added to the database"))
        .catchError((e) => print(e));
  }

  //static Future<void> updateItem({
  Future<void> updateDeposit({
    required String amount,
    required String date,
    required String method,
    required String depositUid,
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
        _userCollection.doc(uid).collection('deposits').doc(depositUid);

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
        .whenComplete(() => print("Deposit updated successfully!"))
        .catchError((e) => print(e));
    //.then((value) async => await readDeposits());
  }

  Stream<QuerySnapshot> readDeposits() {
    CollectionReference depositCollection =
        _userCollection.doc(uid).collection('deposits');

    return depositCollection.snapshots();
  }

  /// Get a stream of a single deposit
  Stream<DepositModel> streamDeposit(String depositUid) {
    CollectionReference depositCollection =
        _userCollection.doc(uid).collection('deposits');
    return depositCollection
        .doc(depositUid)
        .snapshots()
        .map((snap) => DepositModel.fromFirestore(map: snap));
  }

  // Get Stream of Deposit List
  Stream<List<DepositModel>> streamDepositsList() {
    CollectionReference depositCollection =
        _userCollection.doc(uid).collection('deposits');

    return depositCollection
        .orderBy('updatedDate', descending: true)
        .orderBy('updatedTime', descending: true)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => DepositModel.fromFirestore(map: doc))
            .toList());
  }

  // Get Stream of Deposit List for a particular broker
  Stream<List<DepositModel>> streamDepositsListFromBroker(String brokerUid) {
    CollectionReference depositCollection =
        _userCollection.doc(uid).collection('deposits');

    return depositCollection
        .where('brokerUid', isEqualTo: brokerUid)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => DepositModel.fromFirestore(map: doc))
            .toList());
  }

  Future<void> deleteDeposit({
    required String depositUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('deposits').doc(depositUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('A deposit deleted from the database'))
        .catchError((e) => print(e));
  }

  // brew list from snapshot
  List<DepositModel> _depositListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return DepositModel(
        depositUid: doc['depositUid'],
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
  DepositModel? _depositSingleFromSnapshot(DocumentSnapshot snapshot) {
    var depositUid;
    return DepositModel(
      depositUid: depositUid,
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
  Stream<List<DepositModel?>> get depositList {
    return _userCollection
        .doc(uid)
        .collection('deposits')
        .snapshots()
        .map(_depositListFromSnapshot);
  }

  // get user doc stream
  Stream<DepositModel?> get depositSingle {
    return _userCollection
        .doc(uid)
        .collection('deposits')
        .doc(depositUid)
        .snapshots()
        .map(_depositSingleFromSnapshot);
  }
}
