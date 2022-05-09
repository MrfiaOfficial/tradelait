import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../users/models/user.dart';
import '../../users/models/user_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class AuthService {
  var uid;
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid, email: user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  UserModel? _userSingleFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: snapshot['uid'],
      email: snapshot['email'],
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      schoolName: snapshot['schoolName'],
      gender: snapshot['gender'],
      logoUrl: snapshot['logoUrl'],
      phone: snapshot['phone'],
      houseNumber: snapshot['houseNumber'],
      street: snapshot['street'],
      city: snapshot['city'],
      state: snapshot['state'],
      country: snapshot['country'],
    );
  }

  Stream<UserModel?> get userSingle {
    return _userCollection.doc(uid).snapshots().map(_userSingleFromSnapshot);
  }

  // sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
