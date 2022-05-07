import 'package:tradelait/salaries/models/salary_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class SalaryService {
  final String? uid;
  String? salaryUid;
  String? staffUid;

  SalaryService({this.uid});

  Future<void> addSalary({
    required String amount,
    required String purpose,
    //required String salaryType,
    required String date,
    required String method,
    required String balance,
    required String? staffFirstName,
    required String? staffLastName,
    String? staffUid,
    String? salaryUid,
    String? createdTimeStamp,
    String? updatedTimeStamp,
    bool? credit,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('salaries').doc(salaryUid);

    Map<String, dynamic> data = <String, dynamic>{
      "amount": amount,
      "purpose": purpose,
      //'salaryType': salaryType,
      "date": date,
      "method": method,
      "balance": balance,
      'staffFirstName': staffFirstName,
      'staffLastName': staffLastName,
      'staffUid': staffUid,
      "salaryUid": salaryUid,
      'createdTimeStamp': createdTimeStamp,
      'updatedTimeStamp': updatedTimeStamp,
      'credit': credit,
    };

    // await documetReferencer
    return await documentReferencer
        .set(data)
        .whenComplete(() => print("A salary added to the database"))
        .catchError((e) => print(e));
  }

  //static Future<void> updateItem({
  Future<void> updateSalary({
    required String amount,
    required String purpose,
    // required String salaryType,
    required String date,
    required String method,
    required String balance,
    required String? staffFirstName,
    required String? staffLastName,
    String? staffUid,
    String? salaryUid,
    String? createdTimeStamp,
    String? updatedTimeStamp,
    bool? credit,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('salaries').doc(salaryUid);

    Map<String, dynamic> data = <String, dynamic>{
      "amount": amount,
      "purpose": purpose,
      //'salaryType': salaryType,
      "date": date,
      "method": method,
      "balance": balance,
      'staffFirstName': staffFirstName,
      'staffLastName': staffLastName,
      'staffUid': staffUid,
      "salaryUid": salaryUid,
      'createdTimeStamp': createdTimeStamp,
      'updatedTimeStamp': updatedTimeStamp,
      'credit': credit,
    };

    //await documentReferencer
    return await documentReferencer
        .update(data)
        .whenComplete(() => print("Salary updated successfully!"))
        .catchError((e) => print(e));
    //.then((value) async => await readSalarys());
  }

  Stream<QuerySnapshot> readSalaries() {
    CollectionReference salaryCollection =
        _userCollection.doc(uid).collection('salaries');

    return salaryCollection.snapshots();
  }

  /// Get a stream of a single salary
  Stream<SalaryModel> streamSalary(String salaryUid) {
    CollectionReference salaryCollection =
        _userCollection.doc(uid).collection('salaries');
    return salaryCollection
        .doc(salaryUid)
        .snapshots()
        .map((snap) => SalaryModel.fromFirestore(map: snap));
  }

  // Get Stream of Salary List
  Stream<List<SalaryModel>> streamSalariesList() {
    CollectionReference salaryCollection =
        _userCollection.doc(uid).collection('salaries');

    return salaryCollection
        .orderBy('updatedTimeStamp', descending: true)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => SalaryModel.fromFirestore(map: doc))
            .toList());
  }

  // Get Stream of Salary List for a particular student
  Stream<List<SalaryModel>> streamSalariesListFromStudent(String studentUid) {
    CollectionReference salaryCollection =
        _userCollection.doc(uid).collection('salaries');

    return salaryCollection
        .where('staffUid', isEqualTo: studentUid)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => SalaryModel.fromFirestore(map: doc))
            .toList());
  }

  Future<void> deleteSalary({
    required String salaryUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('salaries').doc(salaryUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('A salary deleted from the database'))
        .catchError((e) => print(e));
  }
}
