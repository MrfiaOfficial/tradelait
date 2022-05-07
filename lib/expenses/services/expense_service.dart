import 'package:tradelait/expenses/models/expense_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class ExpenseService {
  final String? uid;
  String? expenseUid;

  ExpenseService({this.uid});

  Future<void> addExpense({
    required String amount,
    required String purpose,
    required String date,
    required String method,
    required String balance,
    String? payeeFirstName,
    String? payeeLastName,
    String? payeeUid,
    String? expenseUid,
    String? createdTimeStamp,
    String? updatedTimeStamp,
    bool? credit,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('expenses').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "amount": amount,
      "purpose": purpose,
      "date": date,
      "method": method,
      "balance": balance,
      'payeeFirstName': payeeFirstName,
      'payeeLastName': payeeLastName,
      'payeeUid': payeeUid,
      "expenseUid": expenseUid,
      'createdTimeStamp': createdTimeStamp,
      'updatedTimeStamp': updatedTimeStamp,
      'credit': credit,
    };

    // await documetReferencer
    return await documentReferencer
        .set(data)
        .whenComplete(() => print("An expense added to the database"))
        .catchError((e) => print(e));
  }

  //static Future<void> updateItem({
  Future<void> updateExpense({
    required String amount,
    required String purpose,
    required String date,
    required String method,
    required String balance,
    String? payeeFirstName,
    String? payeeLastName,
    String? payeeUid,
    String? expenseUid,
    String? createdTimeStamp,
    String? updatedTimeStamp,
    bool? credit,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('expenses').doc(expenseUid);

    Map<String, dynamic> data = <String, dynamic>{
      "amount": amount,
      "purpose": purpose,
      "date": date,
      "method": method,
      "balance": balance,
      'payeeFirstName': payeeFirstName,
      'payeeLastName': payeeLastName,
      'payeeUid': payeeUid,
      "expenseUid": expenseUid,
      'createdTimeStamp': createdTimeStamp,
      'updatedTimeStamp': updatedTimeStamp,
      'credit': credit,
    };

    //await documentReferencer
    return await documentReferencer
        .update(data)
        .whenComplete(() => print("Expense updated successfully!"))
        .catchError((e) => print(e));
    //.then((value) async => await readPayments());
  }

  Stream<QuerySnapshot> readExpenses() {
    CollectionReference expenseCollection =
        _userCollection.doc(uid).collection('expenses');

    return expenseCollection.snapshots();
  }

  /// Get a stream of a single payment
  Stream<ExpenseModel> streamExpense(String expensesUid) {
    CollectionReference expenseCollection =
        _userCollection.doc(uid).collection('expenses');
    return expenseCollection
        .doc(expensesUid)
        .snapshots()
        .map((snap) => ExpenseModel.fromFirestore(map: snap));
  }

  // Get Stream of Payment List
  Stream<List<ExpenseModel>> streamExpensesList() {
    CollectionReference expenseCollection =
        _userCollection.doc(uid).collection('expenses');

    return expenseCollection
        .orderBy('updatedTimeStamp', descending: true)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => ExpenseModel.fromFirestore(map: doc))
            .toList());
  }

  Future<void> deleteExpense({
    required String expenseUid,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(uid).collection('expenses').doc(expenseUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('An expense deleted from the database'))
        .catchError((e) => print(e));
  }
}
