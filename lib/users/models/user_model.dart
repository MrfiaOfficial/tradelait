class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? userName;
  String? schoolName;
  String? gender;
  String? logoUrl;
  String? phone;
  String? houseNumber;
  String? street;
  String? city;
  String? state;
  String? country;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.userName,
    this.schoolName,
    this.gender,
    this.city,
    this.phone,
    this.logoUrl,
    this.houseNumber,
    this.street,
    this.state,
    this.country,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      userName: map['userName'],
      schoolName: map['schoolName'],
      gender: map['gender'],
      logoUrl: map['logoUrl'],
      phone: map['phone'],
      houseNumber: map['houseNumber'],
      street: map['street'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      "userName": userName,
      'schoolName': schoolName,
      "logoUrl": logoUrl,
      "phone": phone,
      "gender": gender,
      "houseNumber": houseNumber,
      "street": street,
      "city": city,
      "state": state,
      "country": country,
    };
  }
}
