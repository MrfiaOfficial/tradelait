import 'package:tradelait/brokers/models/broker_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class BrokerService {
  final String? uid;
  String? brokerUid;
  BrokerService({this.uid});

  Future<void> addBroker({
    required String brokerUid,
    required String brokerName,
    required String brokerType,
    required String joinedDate,
    required String logoUrl,
    required String phone,
    required String email,
    required String country,
    required String timeStamp,
  }) async {
    //
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('brokers').doc(brokerUid);

    Map<String, dynamic> data = <String, dynamic>{
      "brokerUid": brokerUid,
      "brokerName": brokerName,
      "brokerType": brokerType,
      "joinedDate": joinedDate,
      "logoUrl": logoUrl,
      "phone": phone,
      "email": email,
      "country": country,
      "timeStamp": timeStamp,
    };

    return await documentReferencer
        .set(data)
        .whenComplete(() => print("broker added to the database"))
        .catchError((e) => print(e));
  }

  //Update Broker
  Future<void> updateBroker({
    required String brokerUid,
    required String brokerName,
    required String brokerType,
    required String joinedDate,
    required String logoUrl,
    required String phone,
    required String email,
    required String country,
    required String timeStamp,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('brokers').doc(brokerUid);

    Map<String, dynamic> data = <String, dynamic>{
      "brokerUid": brokerUid,
      "brokerName": brokerName,
      "brokerType": brokerType,
      "joinedDate": joinedDate,
      "logoUrl": logoUrl,
      "phone": phone,
      "email": email,
      "country": country,
      "timeStamp": timeStamp,
    };

    //await documentReferencer
    return await documentReferencer
        .update(data)
        .whenComplete(() => print("broker updated in the database"))
        .catchError((e) => print(e));
  }

  // Get Future of broker List to be used in TypeAhead Form Field
  Future<List<brokerData>> futureBrokers(String query) async {
    CollectionReference brokerCollection =
        _userCollection.doc(uid).collection('brokers');

    return await brokerCollection.get().then(
          (QuerySnapshot list) async => list.docs
              .map((doc) => brokerData.fromFirestore(map: doc))
              .where((broker) {
            final brokerName = broker.brokerName!.toLowerCase().toString();
            final queryLower = query.toLowerCase();

            return brokerName.contains(queryLower);
          }).toList(),
        );
  }

  // Get Future of broker List to be used in TypeAhead Form Field
  Future<Iterable> futureBrokerList(String query) async {
    CollectionReference brokerCollection =
        _userCollection.doc(uid).collection('brokers');

    return await brokerCollection.get().then(
          (QuerySnapshot list) async => list.docs.where((broker) {
            final brokerName = broker["brokerName"].toLowerCase().toString();
            final queryLower = query.toLowerCase();

            return brokerName.contains(queryLower);
          }).toList(),
        );
  }

  Future futurestuds(String query) async {
    CollectionReference brokerCollection =
        _userCollection.doc(uid).collection('brokers');

    final QuerySnapshot brokers = await brokerCollection.get();

    final List<DocumentSnapshot> documents = brokers.docs;

    List<String> brokerListString = []; // My list I want to create.

    documents.forEach((snapshot) {
      brokerListString.add(snapshot['brokerName']);
    });

    return brokerListString;
  }

  //static Stream<QuerySnapshot> readItems() {
  Stream<QuerySnapshot> readBrokers() {
    CollectionReference brokerCollection =
        _userCollection.doc(uid).collection('brokers');

    return brokerCollection
        .orderBy('brokerName', descending: false)
        .snapshots();
  }

  //read single broker using its brokerUid
  Stream<DocumentSnapshot> readSingleBroker(brokerUid) {
    DocumentReference singleBroker =
        _userCollection.doc(uid).collection('brokers').doc(brokerUid);

    return singleBroker.snapshots();
  }

  // Get a stream of a single payment
  Stream<brokerData> streamBroker(String brokerUid) {
    CollectionReference brokerCollection =
        _userCollection.doc(uid).collection('brokers');
    return brokerCollection
        .doc(brokerUid)
        .snapshots()
        .map((snap) => brokerData.fromFirestore(map: snap));
  }

  // Get Stream of broker List
  Stream<List<brokerData>> streamBrokersList() {
    CollectionReference brokerCollection =
        _userCollection.doc(uid).collection('brokers');

    return brokerCollection.snapshots().map((list) =>
        list.docs.map((doc) => brokerData.fromFirestore(map: doc)).toList());
  }

  /// Get Stream of broker List
  /* Stream<List<brokerData>> initialDataList() {
    return brokerData.initialData().toMap().toList();
  } */

  //static Future<void> deletebroker({
  Future<void> deleteBroker({
    required String brokerUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('brokers').doc(brokerUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('broker deleted from the database'))
        .catchError((e) => print(e));
  }

  // brew list from snapshot
  List<brokerData> _brokerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return brokerData(
        brokerName: doc['brokerName'] ?? '',
        brokerUid: doc['brokerUid'] ?? '',
      );
    }).toList();
  }

  // broker data from snapshots
  brokerData? _brokerSingleFromSnapshot(DocumentSnapshot snapshot) {
    var brokerUid;
    return brokerData(
      brokerUid: brokerUid,
      brokerName: snapshot['brokerName'],
    );
  }

  // get brews stream
  Stream<List<brokerData?>> get brokerList {
    return _userCollection
        .doc(uid)
        .collection('brokers')
        .snapshots()
        .map(_brokerListFromSnapshot);
  }

  // get user doc stream
  Stream<brokerData?> get brokerSingle {
    return _userCollection
        .doc(uid)
        .collection('brokers')
        .doc(brokerUid)
        .snapshots()
        .map(_brokerSingleFromSnapshot);
  }
}

class BrokerService2 {
  final String? uid;

  BrokerService2(this.uid);

  Future<Iterable<String>> futureStuds(String query) async {
    CollectionReference brokerCollection =
        _userCollection.doc(uid).collection('brokers');

    final QuerySnapshot brokers = await brokerCollection.get();

    final List<DocumentSnapshot> documents = brokers.docs;

    List<String> brokerListString = []; // My list I want to create.

    documents.forEach((snapshot) {
      brokerListString.add(snapshot['brokerName']);
    });

    return brokerListString;
  }
}

class BrokerService3 {
  final String? uid;

  BrokerService3(this.uid);

  futureStuds() async {
    CollectionReference brokerCollection =
        _userCollection.doc(uid).collection('brokers');

    final QuerySnapshot brokers = await brokerCollection.get();
    final List<DocumentSnapshot> documents = brokers.docs;

    List brokerList = []; // My list I want to create.
    documents.forEach((snapshot) {
      brokerList.add(snapshot);
    });

    return brokerList;
  }
}
