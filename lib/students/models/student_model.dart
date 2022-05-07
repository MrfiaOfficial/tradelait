import 'package:cloud_firestore/cloud_firestore.dart';

/* final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users'); */

class StudentData {
  String studentUid;
  String? firstName;
  String? lastName;
  String? studentClass;
  String? gender;
  String? dob;
  String? joinedDate;
  String? schoolType;
  String? pictureUrl;
  String? phone;
  String? email;
  String? houseNumber;
  String? street;
  String? city;
  String? state;
  String? country;
  String? timeStamp;
  //String? uid;

  StudentData({
    required this.studentUid,
    this.firstName,
    this.lastName,
    this.studentClass,
    this.gender,
    this.dob,
    this.joinedDate,
    this.schoolType,
    this.pictureUrl,
    this.phone,
    this.email,
    this.houseNumber,
    this.street,
    this.city,
    this.state,
    this.country,
    this.timeStamp,
  });

  factory StudentData.fromMap(map) {
    return StudentData(
      studentUid: map['studentUid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      studentClass: map['studentClass'],
      gender: map['gender'],
      dob: map['dob'],
      joinedDate: map['joinedDate'],
      schoolType: map['schoolType'],
      pictureUrl: map['pictureUrl'],
      phone: map['phone'],
      email: map['email'],
      houseNumber: map['houseNumber'],
      street: map['street'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      timeStamp: map['timeStamp'],
    );
  }

  factory StudentData.fromFirestore({required DocumentSnapshot map}) {
    return StudentData(
      studentUid: map.id,
      firstName: map['firstName'],
      lastName: map['lastName'],
      studentClass: map['studentClass'],
      gender: map['gender'],
      dob: map['dob'],
      joinedDate: map['joinedDate'],
      schoolType: map['schoolType'],
      pictureUrl: map['pictureUrl'],
      phone: map['phone'],
      email: map['email'],
      houseNumber: map['houseNumber'],
      street: map['street'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      timeStamp: map['timeStamp'],
    );
  }

  //get studentList => null;

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
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
  }

  factory StudentData.initialData() {
    return StudentData(
        studentUid: '',
        firstName: '',
        lastName: '',
        studentClass: '',
        gender: '',
        dob: '',
        joinedDate: '',
        schoolType: '',
        pictureUrl: '',
        phone: '',
        email: '',
        houseNumber: '',
        street: '',
        city: '',
        state: '',
        country: '',
        timeStamp: '');
  }

  // Get Future of Student List to be used in TypeAhead Form Field
  /* Future<List<StudentData>> futureStudents(String query) async {
    CollectionReference studentCollection =
        _userCollection.doc(uid).collection('students');

    return await studentCollection.get().then(
          (QuerySnapshot list) async => list.docs
              .map((doc) => StudentData.fromFirestore(map: doc))
              .where((student) {
            final firstNameLower = student.firstName!.toLowerCase();
            final lastNameLower = student.lastName!.toLowerCase();
            final fullName = firstNameLower + lastNameLower;
            final queryLower = query.toLowerCase();

            return fullName.contains(queryLower);
          }).toList(),
        );
  } */
}
