import 'package:tradelait/users/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class UserService {
  final String? uid;
  UserService({this.uid});

  Future<void> addUser({
    required String firstName,
    required String lastName,
    required String userName,
    required String gender,
    required String schoolName,
    required String pictureUrl,
    required String phone,
    required String email,
    required String houseNumber,
    required String street,
    required String city,
    required String state,
    required String country,
  }) async {
    DocumentReference documentReferencer = _userCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "gender": gender,
      "schoolType": schoolName,
      "pictureUrl": pictureUrl,
      "phone": phone,
      "email": email,
      "houseNumber": houseNumber,
      "street": street,
      "city": city,
      "state": state,
      "country": country,
    };

    // await documetReferencer
    return await documentReferencer
        .set(data)
        .whenComplete(() => print("Student added to the database"))
        .catchError((e) => print(e));
  }

  //static Future<void> updateItem({
  Future<void> updateUser({
    required String firstName,
    required String lastName,
    required String userName,
    required String gender,
    required String schoolName,
    required String pictureUrl,
    required String phone,
    required String email,
    required String houseNumber,
    required String street,
    required String city,
    required String state,
    required String country,
  }) async {
    DocumentReference documentReferencer = _userCollection.doc(uid);

    Map<String, dynamic> data = <String, dynamic>{
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "gender": gender,
      "schoolName": schoolName,
      "pictureUrl": pictureUrl,
      "phone": phone,
      "email": email,
      "houseNumber": houseNumber,
      "street": street,
      "city": city,
      "state": state,
      "country": country,
    };

    //await documentReferencer
    return await documentReferencer
        .update(data)
        .whenComplete(() => print("User updated in the database"))
        .catchError((e) => print(e));
  }

  //static Stream<QuerySnapshot> readItems() {
  Stream<QuerySnapshot> readUsers() {
    return _userCollection.snapshots();
  }

  //static Future<void> deleteStudent({
  Future<void> deleteUser({
    required String uid,
  }) async {
    DocumentReference documentReferencer = _userCollection.doc(uid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('User deleted from the database'))
        .catchError((e) => print(e));
  }

  // brew list from snapshot
  List<UserModel> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((map) {
      //print(doc.data);
      return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        userName: map['userName'],
        schoolName: map['schoolName'],
        gender: map['gender'],
        pictureUrl: map['pictureUrl'],
        phone: map['phone'],
        houseNumber: map['houseNumber'],
        street: map['street'],
        city: map['city'],
        state: map['state'],
        country: map['country'],
      );
    }).toList();
  }

  // student data from snapshots
  UserModel? _userSingleFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: snapshot['uid'],
      email: snapshot['email'],
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      userName: snapshot['userName'],
      schoolName: snapshot['schoolName'],
      gender: snapshot['gender'],
      pictureUrl: snapshot['pictureUrl'],
      phone: snapshot['phone'],
      houseNumber: snapshot['houseNumber'],
      street: snapshot['street'],
      city: snapshot['city'],
      state: snapshot['state'],
      country: snapshot['country'],
    );
  }

  // get users stream
  Stream<List<UserModel?>> get userList {
    return _userCollection.snapshots().map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserModel?> get userSingle {
    return _userCollection.doc(uid).snapshots().map(_userSingleFromSnapshot);
  }
}
