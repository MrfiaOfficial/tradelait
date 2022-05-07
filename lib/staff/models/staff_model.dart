import 'package:cloud_firestore/cloud_firestore.dart';

class StaffData {
  String staffUid;
  String? firstName;
  String? lastName;
  String? qualification;
  String? jobType;
  String? salary;
  String? gender;
  String? dob;
  String? joinedDate;
  String? pictureUrl;
  String? phone;
  String? email;
  String? houseNumber;
  String? street;
  String? city;
  String? state;
  String? country;
  String? timeStamp;

  StaffData({
    required this.staffUid,
    this.firstName,
    this.lastName,
    this.qualification,
    this.gender,
    this.dob,
    this.joinedDate,
    this.jobType,
    this.pictureUrl,
    this.phone,
    this.email,
    this.houseNumber,
    this.street,
    this.city,
    this.state,
    this.country,
    this.timeStamp,
    this.salary,
  });

  factory StaffData.fromMap(map) {
    return StaffData(
      staffUid: map['staffUid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      qualification: map['qualification'],
      gender: map['gender'],
      dob: map['dob'],
      joinedDate: map['joinedDate'],
      jobType: map['schoolType'],
      pictureUrl: map['pictureUrl'],
      phone: map['phone'],
      email: map['email'],
      houseNumber: map['houseNumber'],
      street: map['street'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      timeStamp: map['timeStamp'],
      salary: map['salary'],
    );
  }

  factory StaffData.fromFirestore({required DocumentSnapshot map}) {
    return StaffData(
      staffUid: map.id,
      firstName: map['firstName'],
      lastName: map['lastName'],
      qualification: map['staffClass'],
      gender: map['gender'],
      dob: map['dob'],
      joinedDate: map['joinedDate'],
      jobType: map['schoolType'],
      pictureUrl: map['pictureUrl'],
      phone: map['phone'],
      email: map['email'],
      houseNumber: map['houseNumber'],
      street: map['street'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      timeStamp: map['timeStamp'],
      salary: map['salary'],
    );
  }

  //get staffList => null;

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "staffClass": qualification,
      "gender": gender,
      "dob": dob,
      "joinedDate": joinedDate,
      "schoolType": jobType,
      "pictureUrl": pictureUrl,
      "phone": phone,
      "email": email,
      "houseNumber": houseNumber,
      "street": street,
      "city": city,
      "state": state,
      "country": country,
      "timeStamp": timeStamp,
      'salary': salary,
    };
  }

  factory StaffData.initialData() {
    return StaffData(
      staffUid: '',
      firstName: '',
      lastName: '',
      qualification: '',
      gender: '',
      dob: '',
      joinedDate: '',
      jobType: '',
      pictureUrl: '',
      phone: '',
      email: '',
      houseNumber: '',
      street: '',
      city: '',
      state: '',
      country: '',
      timeStamp: '',
      salary: '',
    );
  }
}
