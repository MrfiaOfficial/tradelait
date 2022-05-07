import 'package:tradelait/staff/models/staff_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class StaffService {
  //static String? uid;
  final String? uid;
  String? staffUid;
  //String? customStaffUid;
  StaffService({this.uid});

  Future<void> addStaff({
    required String staffUid,
    required String firstName,
    required String lastName,
    required String qualification,
    required String jobType,
    required String salary,
    required String gender,
    required String dob,
    required String joinedDate,
    required String pictureUrl,
    required String phone,
    required String email,
    required String houseNumber,
    required String street,
    required String city,
    required String state,
    required String country,
    required String timeStamp,
  }) async {
    //
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('staff').doc(staffUid);

    Map<String, dynamic> data = <String, dynamic>{
      "staffUid": staffUid,
      "firstName": firstName,
      "lastName": lastName,
      "qualification": qualification,
      "jobType": jobType,
      "salary": salary,
      "gender": gender,
      "dob": dob,
      "joinedDate": joinedDate,
      "pictureUrl": pictureUrl,
      "phone": phone,
      "email": email,
      "houseNumber": houseNumber,
      "street": street,
      "city": city,
      "state": state,
      "country": country,
      "timeStamp": timeStamp,
    };

    // await documetReferencer

    return await documentReferencer
        .set(data)
        .whenComplete(() => print("Staff added to the database"))
        .catchError((e) => print(e));
  }

  Future<void> updateStaff({
    required String staffUid,
    required String firstName,
    required String lastName,
    required String qualification,
    required String jobType,
    required String salary,
    required String gender,
    required String dob,
    required String joinedDate,
    required String pictureUrl,
    required String phone,
    required String email,
    required String houseNumber,
    required String street,
    required String city,
    required String state,
    required String country,
    required String timeStamp,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('staff').doc(staffUid);

    Map<String, dynamic> data = <String, dynamic>{
      "staffUid": staffUid,
      "firstName": firstName,
      "lastName": lastName,
      "qualification": qualification,
      "jobType": jobType,
      "salary": salary,
      "gender": gender,
      "dob": dob,
      "joinedDate": joinedDate,
      "pictureUrl": pictureUrl,
      "phone": phone,
      "email": email,
      "houseNumber": houseNumber,
      "street": street,
      "city": city,
      "state": state,
      "country": country,
      "timeStamp": timeStamp,
    };

    //await documentReferencer
    return await documentReferencer
        .update(data)
        .whenComplete(() => print("Staff updated in the database"))
        .catchError((e) => print(e));
  }

  // Get Future of Staff List to be used in TypeAhead Form Field
  Future<List<StaffData>> futureStaff(String query) async {
    CollectionReference staffCollection =
        _userCollection.doc(uid).collection('staff');

    return await staffCollection.get().then(
          (QuerySnapshot list) async => list.docs
              .map((doc) => StaffData.fromFirestore(map: doc))
              .where((staff) {
            final firstNameLower = staff.firstName!.toLowerCase();
            final lastNameLower = staff.lastName!.toLowerCase();
            final fullName = (firstNameLower + lastNameLower).toString();
            final queryLower = query.toLowerCase();

            return fullName.contains(queryLower);
          }).toList(),
        );
  }

  // Get Future of Staff List to be used in TypeAhead Form Field
  Future<Iterable> futureStaffList(String query) async {
    CollectionReference staffCollection =
        _userCollection.doc(uid).collection('staff');

    return await staffCollection.get().then(
          (QuerySnapshot list) async => list.docs.where((staff) {
            final firstNameLower = staff["firstName"].toLowerCase();
            final lastNameLower = staff["lastName"].toLowerCase();
            final fullName = (firstNameLower + lastNameLower).toString();
            final queryLower = query.toLowerCase();

            return fullName.contains(queryLower);
          }).toList(),
        );
  }

  Future futureSta(String query) async {
    CollectionReference staffCollection =
        _userCollection.doc(uid).collection('staff');

    final QuerySnapshot staff = await staffCollection.get();

    final List<DocumentSnapshot> documents = staff.docs;

    List<String> staffListString = []; // My list I want to create.

    documents.forEach((snapshot) {
      staffListString.add(snapshot['firstName']);
    });

    return staffListString;
  }

  //static Stream<QuerySnapshot> readItems() {
  Stream<QuerySnapshot> readStaff() {
    CollectionReference staffCollection =
        _userCollection.doc(uid).collection('staff');

    return staffCollection.orderBy('firstName', descending: false).snapshots();
  }

  //read single staff using its staffUid
  Stream<DocumentSnapshot> readSingleStaff(staffUid) {
    DocumentReference singleStaff =
        _userCollection.doc(uid).collection('staff').doc(staffUid);

    return singleStaff.snapshots();
  }

  // Get a stream of a single payment
  Stream<StaffData> streamStaff(String staffUid) {
    CollectionReference staffCollection =
        _userCollection.doc(uid).collection('staff');
    return staffCollection
        .doc(staffUid)
        .snapshots()
        .map((snap) => StaffData.fromFirestore(map: snap));
  }

  // Get Stream of Staff List
  Stream<List<StaffData>> streamStaffList() {
    CollectionReference staffCollection =
        _userCollection.doc(uid).collection('staff');

    return staffCollection.snapshots().map((list) =>
        list.docs.map((doc) => StaffData.fromFirestore(map: doc)).toList());
  }

  /// Get Stream of Staff List
  /* Stream<List<StaffData>> initialDataList() {
    return StaffData.initialData().toMap().toList();
  } */

  //static Future<void> deleteStaff({
  Future<void> deleteStaff({
    required String staffUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('staff').doc(staffUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Staff deleted from the database'))
        .catchError((e) => print(e));
  }

  // brew list from snapshot
  List<StaffData> _staffListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return StaffData(
        firstName: doc['firstName'] ?? '',
        lastName: doc['lastName'] ?? '',
        staffUid: doc['staffUid'] ?? '',
      );
    }).toList();
  }

  // staff data from snapshots
  StaffData? _staffSingleFromSnapshot(DocumentSnapshot snapshot) {
    var staffUid;
    return StaffData(
      staffUid: staffUid,
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
    );
  }

  // get brews stream
  Stream<List<StaffData?>> get staffList {
    return _userCollection
        .doc(uid)
        .collection('staff')
        .snapshots()
        .map(_staffListFromSnapshot);
  }

  // get user doc stream
  Stream<StaffData?> get staffSingle {
    return _userCollection
        .doc(uid)
        .collection('staff')
        .doc(staffUid)
        .snapshots()
        .map(_staffSingleFromSnapshot);
  }
}

class StaffService2 {
  final String? uid;

  StaffService2(this.uid);

  Future<Iterable<String>> futureStaffListString(String query) async {
    CollectionReference staffCollection =
        _userCollection.doc(uid).collection('staff');

    final QuerySnapshot staff = await staffCollection.get();

    final List<DocumentSnapshot> documents = staff.docs;

    List<String> staffListString = []; // My list I want to create.

    documents.forEach((snapshot) {
      staffListString.add(snapshot['firstName']);
    });

    return staffListString;
  }
}

class StaffService3 {
  final String? uid;

  StaffService3(this.uid);

  futureStaffList() async {
    CollectionReference staffCollection =
        _userCollection.doc(uid).collection('staff');

    final QuerySnapshot staff = await staffCollection.get();
    final List<DocumentSnapshot> documents = staff.docs;

    List staffList = []; // My list I want to create.
    documents.forEach((snapshot) {
      staffList.add(snapshot);
    });

    return staffList;
  }
}
