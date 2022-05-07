import 'package:tradelait/students/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class StudentService {
  //static String? uid;
  final String? uid;
  String? studentUid;
  //String? customStudentUid;
  StudentService({this.uid});

  Future<void> addStudent({
    required String studentUid,
    required String firstName,
    required String lastName,
    required String studentClass,
    required String gender,
    required String dob,
    required String joinedDate,
    required String schoolType,
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
        _userCollection.doc(uid).collection('students').doc(studentUid);

    Map<String, dynamic> data = <String, dynamic>{
      "studentUid": studentUid,
      "firstName": firstName,
      "lastName": lastName,
      "studentClass": studentClass,
      "gender": gender,
      "dob": dob,
      "joinedDate": joinedDate,
      "schoolType": schoolType,
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
    /* print(data.toString());
    print(data.length);
    print(data.values); */
    return await documentReferencer
        .set(data)
        .whenComplete(() => print("Student added to the database"))
        .catchError((e) => print(e));
  }

  //static Future<void> updateItem({
  Future<void> updateStudent({
    required String studentUid,
    required String firstName,
    required String lastName,
    required String studentClass,
    required String gender,
    required String dob,
    required String joinedDate,
    required String schoolType,
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
        _userCollection.doc(uid).collection('students').doc(studentUid);

    Map<String, dynamic> data = <String, dynamic>{
      "studentUid": studentUid,
      "firstName": firstName,
      "lastName": lastName,
      "studentClass": studentClass,
      "gender": gender,
      "dob": dob,
      "joinedDate": joinedDate,
      "schoolType": schoolType,
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
        .whenComplete(() => print("Student updated in the database"))
        .catchError((e) => print(e));
  }

  // Get Future of Student List to be used in TypeAhead Form Field
  Future<List<StudentData>> futureStudents(String query) async {
    CollectionReference studentCollection =
        _userCollection.doc(uid).collection('students');

    return await studentCollection.get().then(
          (QuerySnapshot list) async => list.docs
              .map((doc) => StudentData.fromFirestore(map: doc))
              .where((student) {
            final firstNameLower = student.firstName!.toLowerCase();
            final lastNameLower = student.lastName!.toLowerCase();
            final fullName = (firstNameLower + lastNameLower).toString();
            final queryLower = query.toLowerCase();

            return fullName.contains(queryLower);
          }).toList(),
        );
  }

  // Get Future of Student List to be used in TypeAhead Form Field
  Future<Iterable> futureStudentList(String query) async {
    CollectionReference studentCollection =
        _userCollection.doc(uid).collection('students');

    return await studentCollection.get().then(
          (QuerySnapshot list) async => list.docs.where((student) {
            final firstNameLower = student["firstName"].toLowerCase();
            final lastNameLower = student["lastName"].toLowerCase();
            final fullName = (firstNameLower + lastNameLower).toString();
            final queryLower = query.toLowerCase();

            return fullName.contains(queryLower);
          }).toList(),
        );
  }

  Future futurestuds(String query) async {
    CollectionReference studentCollection =
        _userCollection.doc(uid).collection('students');

    final QuerySnapshot students = await studentCollection.get();

    final List<DocumentSnapshot> documents = students.docs;

    List<String> studentListString = []; // My list I want to create.

    documents.forEach((snapshot) {
      studentListString.add(snapshot['firstName']);
    });

    return studentListString;
  }

  //static Stream<QuerySnapshot> readItems() {
  Stream<QuerySnapshot> readStudents() {
    CollectionReference studentCollection =
        _userCollection.doc(uid).collection('students');

    return studentCollection
        .orderBy('firstName', descending: false)
        .snapshots();
  }

  //read single student using its studentUid
  Stream<DocumentSnapshot> readSingleStudent(studentUid) {
    DocumentReference singleStudent =
        _userCollection.doc(uid).collection('students').doc(studentUid);

    return singleStudent.snapshots();
  }

  // Get a stream of a single payment
  Stream<StudentData> streamStudent(String studentUid) {
    CollectionReference studentCollection =
        _userCollection.doc(uid).collection('students');
    return studentCollection
        .doc(studentUid)
        .snapshots()
        .map((snap) => StudentData.fromFirestore(map: snap));
  }

  // Get Stream of Student List
  Stream<List<StudentData>> streamStudentsList() {
    CollectionReference studentCollection =
        _userCollection.doc(uid).collection('students');

    return studentCollection.snapshots().map((list) =>
        list.docs.map((doc) => StudentData.fromFirestore(map: doc)).toList());
  }

  /// Get Stream of Student List
  /* Stream<List<StudentData>> initialDataList() {
    return StudentData.initialData().toMap().toList();
  } */

  //static Future<void> deleteStudent({
  Future<void> deleteStudent({
    required String studentUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('students').doc(studentUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Student deleted from the database'))
        .catchError((e) => print(e));
  }

  // brew list from snapshot
  List<StudentData> _studentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return StudentData(
        firstName: doc['firstName'] ?? '',
        lastName: doc['lastName'] ?? '',
        studentUid: doc['studentUid'] ?? '',
      );
    }).toList();
  }

  // student data from snapshots
  StudentData? _studentSingleFromSnapshot(DocumentSnapshot snapshot) {
    var studentUid;
    return StudentData(
      studentUid: studentUid,
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
    );
  }

  // get brews stream
  Stream<List<StudentData?>> get studentList {
    return _userCollection
        .doc(uid)
        .collection('students')
        .snapshots()
        .map(_studentListFromSnapshot);
  }

  // get user doc stream
  Stream<StudentData?> get studentSingle {
    return _userCollection
        .doc(uid)
        .collection('students')
        .doc(studentUid)
        .snapshots()
        .map(_studentSingleFromSnapshot);
  }
}

class StudentService2 {
  final String? uid;

  StudentService2(this.uid);

  Future<Iterable<String>> futureStuds(String query) async {
    CollectionReference studentCollection =
        _userCollection.doc(uid).collection('students');

    final QuerySnapshot students = await studentCollection.get();

    final List<DocumentSnapshot> documents = students.docs;

    List<String> studentListString = []; // My list I want to create.

    documents.forEach((snapshot) {
      studentListString.add(snapshot['firstName']);
    });

    return studentListString;
  }
}

class StudentService3 {
  final String? uid;

  StudentService3(this.uid);

  futureStuds() async {
    CollectionReference studentCollection =
        _userCollection.doc(uid).collection('students');

    final QuerySnapshot students = await studentCollection.get();
    final List<DocumentSnapshot> documents = students.docs;

    List studentList = []; // My list I want to create.
    documents.forEach((snapshot) {
      studentList.add(snapshot);
    });

    return studentList;
  }
}
