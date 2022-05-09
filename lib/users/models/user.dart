class User {
  final String? uid;
  final String? email;

  User({this.uid, this.email});
}

class UserData {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? schoolName;

  UserData(
      {this.uid, this.email, this.firstName, this.lastName, this.schoolName});

  factory UserData.fromMap(map) {
    return UserData(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      schoolName: map['schoolName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'schoolName': schoolName,
    };
  }
}
