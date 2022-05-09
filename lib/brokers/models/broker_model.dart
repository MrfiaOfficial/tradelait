import 'package:cloud_firestore/cloud_firestore.dart';

/* final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users'); */

class brokerData {
  String brokerUid;
  String? brokerName;
  String? joinedDate;
  String? brokerType;
  String? logoUrl;
  String? phone;
  String? email;
  String? country;
  String? timeStamp;

  brokerData({
    required this.brokerUid,
    this.brokerName,
    this.brokerType,
    this.joinedDate,
    this.logoUrl,
    this.phone,
    this.email,
    this.country,
    this.timeStamp,
  });

  factory brokerData.fromMap(map) {
    return brokerData(
      brokerUid: map['brokerUid'],
      brokerName: map['brokerName'],
      brokerType: map['brokerType'],
      joinedDate: map['joinedDate'],
      logoUrl: map['logoUrl'],
      phone: map['phone'],
      email: map['email'],
      country: map['country'],
      timeStamp: map['timeStamp'],
    );
  }

  factory brokerData.fromFirestore({required DocumentSnapshot map}) {
    return brokerData(
      brokerUid: map.id,
      brokerName: map['brokerName'],
      brokerType: map['brokerType'],
      joinedDate: map['joinedDate'],
      logoUrl: map['logoUrl'],
      phone: map['phone'],
      email: map['email'],
      country: map['country'],
      timeStamp: map['timeStamp'],
    );
  }

  //get brokerList => null;

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      "brokerName": brokerName,
      "brokerType": brokerType,
      "joinedDate": joinedDate,
      "brokerType": brokerType,
      "logoUrl": logoUrl,
      "phone": phone,
      "email": email,
      "country": country,
      "timeStamp": timeStamp,
    };
  }

  factory brokerData.initialData() {
    return brokerData(
        brokerUid: '',
        brokerName: '',
        brokerType: '',
        joinedDate: '',
        logoUrl: '',
        phone: '',
        email: '',
        country: '',
        timeStamp: '');
  }

  // Get Future of broker List to be used in TypeAhead Form Field
  /* Future<List<brokerData>> futurebrokers(String query) async {
    CollectionReference brokerCollection =
        _userCollection.doc(uid).collection('brokers');

    return await brokerCollection.get().then(
          (QuerySnapshot list) async => list.docs
              .map((doc) => brokerData.fromFirestore(map: doc))
              .where((broker) {
            final brokerNameLower = broker.brokerName!.toLowerCase();
            final lastNameLower = broker.lastName!.toLowerCase();
            final fullName = brokerNameLower + lastNameLower;
            final queryLower = query.toLowerCase();

            return fullName.contains(queryLower);
          }).toList(),
        );
  } */
}
