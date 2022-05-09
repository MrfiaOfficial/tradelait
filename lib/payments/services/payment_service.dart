import 'package:tradelait/payments/models/payment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class PaymentService {
  //static String? uid;
  final String? uid;
  String? brokerUid;
  String? paymentUid;
  String? payerUid;

  PaymentService({this.uid});

  Future<void> addPayment({
    required String amount,
    required String purpose,
    required String date,
    required String method,
    required String balance,
    required String? payerBrokerName,
    required String? payerLastName,
    String? payerUid,
    String? paymentUid,
    String? createdDate,
    String? updatedDate,
    String? createdTime,
    String? updatedTime,
    String? timeStamp,
    bool? credit,
    //String? customPaymentUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('payments').doc(paymentUid);

    Map<String, dynamic> data = <String, dynamic>{
      "amount": amount,
      "purpose": purpose,
      "date": date,
      "method": method,
      "balance": balance,
      'payerBrokerName': payerBrokerName,
      'payerLastName': payerLastName,
      'payerUid': payerUid,
      "paymentUid": paymentUid,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'timeStamp': timeStamp,
      'credit': credit,
      //'customPaymentUid': customPaymentUid,
    };

    // await documetReferencer
    return await documentReferencer
        .set(data)
        .whenComplete(() => print("A payment added to the database"))
        .catchError((e) => print(e));
  }

  //static Future<void> updateItem({
  Future<void> updatePayment({
    required String amount,
    required String purpose,
    required String date,
    required String method,
    required String paymentUid,
    required String balance,
    required String? payerBrokerName,
    required String? payerLastName,
    String? payerUid,
    String? createdDate,
    String? updatedDate,
    String? createdTime,
    String? updatedTime,
    String? timeStamp,
    bool? credit,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('payments').doc(paymentUid);

    Map<String, dynamic> data = <String, dynamic>{
      "amount": amount,
      "purpose": purpose,
      "date": date,
      "method": method,
      "balance": balance,
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

    //await documentReferencer
    return await documentReferencer
        .update(data)
        .whenComplete(() => print("Payment updated successfully!"))
        .catchError((e) => print(e));
    //.then((value) async => await readPayments());
  }

  Stream<QuerySnapshot> readPayments() {
    CollectionReference paymentCollection =
        _userCollection.doc(uid).collection('payments');

    return paymentCollection.snapshots();
  }

  /// Get a stream of a single payment
  Stream<PaymentModel> streamPayment(String paymentUid) {
    CollectionReference paymentCollection =
        _userCollection.doc(uid).collection('payments');
    return paymentCollection
        .doc(paymentUid)
        .snapshots()
        .map((snap) => PaymentModel.fromFirestore(map: snap));
  }

  // Get Stream of Payment List
  Stream<List<PaymentModel>> streamPaymentsList() {
    CollectionReference paymentCollection =
        _userCollection.doc(uid).collection('payments');

    return paymentCollection
        .orderBy('updatedDate', descending: true)
        .orderBy('updatedTime', descending: true)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => PaymentModel.fromFirestore(map: doc))
            .toList());
  }

  // Get Stream of Payment List for a particular broker
  Stream<List<PaymentModel>> streamPaymentsListFromBroker(String brokerUid) {
    CollectionReference paymentCollection =
        _userCollection.doc(uid).collection('payments');

    return paymentCollection
        .where('payerUid', isEqualTo: brokerUid)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => PaymentModel.fromFirestore(map: doc))
            .toList());
  }

  Future<void> deletePayment({
    required String paymentUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('payments').doc(paymentUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('A payment deleted from the database'))
        .catchError((e) => print(e));
  }

  // brew list from snapshot
  List<PaymentModel> _paymentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return PaymentModel(
        paymentUid: doc['paymentUid'],
        amount: doc['amount'] ?? '0',
        purpose: doc['purpose'] ?? '',
        date: doc['date'] ?? 0,
        method: doc['method'] ?? '',
        balance: doc['balance'] ?? '',
        payerBrokerName: doc['payerBrokerName'] ?? '',
        payerLastName: doc['payerLastName'] ?? '',
        payerUid: doc['payerUid'] ?? '',
        createdDate: doc['createdDate'],
        updatedDate: doc['updatedDate'],
        createdTime: doc['createdTime'],
        updatedTime: doc['updatedTime'],
      );
    }).toList();
  }

  // broker data from snapshots
  PaymentModel? _paymentSingleFromSnapshot(DocumentSnapshot snapshot) {
    var paymentUid;
    return PaymentModel(
      paymentUid: paymentUid,
      amount: snapshot['amount'],
      purpose: snapshot['purpose'],
      date: snapshot['date'],
      method: snapshot['method'],
      balance: snapshot['balance'],
      payerBrokerName: snapshot['payerBrokerName'],
      payerLastName: snapshot['payerLastName'],
      payerUid: snapshot['payerUid'],
      createdDate: snapshot['createdDate'],
      updatedDate: snapshot['updatedDate'],
      createdTime: snapshot['createdTime'],
      updatedTime: snapshot['updatedTime'],
    );
  }

  // get brews stream
  Stream<List<PaymentModel?>> get paymentList {
    return _userCollection
        .doc(uid)
        .collection('payments')
        .snapshots()
        .map(_paymentListFromSnapshot);
  }

  // get user doc stream
  Stream<PaymentModel?> get paymentSingle {
    return _userCollection
        .doc(uid)
        .collection('payments')
        .doc(paymentUid)
        .snapshots()
        .map(_paymentSingleFromSnapshot);
  }
}
