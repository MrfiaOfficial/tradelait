import 'package:tradelait/payments/screens/payment_fromBroker_add_screen.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/brokers/screens/broker_edit_screen.dart';
//import 'package:tradelait/brokers/screens/unused_brokers/broker_single_screen_2.dart';
import 'package:tradelait/brokers/screens/broker_single_screen.dart';
import 'package:tradelait/widgets/custom_search_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/brokers/services/broker_service.dart';

class BrokerList extends StatefulWidget {
  @override
  State<BrokerList> createState() => _BrokerListState();
}

class _BrokerListState extends State<BrokerList> {
  TextEditingController _searchController = TextEditingController();

  CollectionReference allNoteCollection =
      FirebaseFirestore.instance.collection('brokers');

  List<DocumentSnapshot> documents = [];

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    return Container(
      child: Column(
        children: [
          CustomSearchFormField(
            isLabelEnabled: false,
            controller: _searchController,
            keyboardType: TextInputType.text,
            inputAction: TextInputAction.next,
            validator: (value) => DbValidator.validateField(
              value: value,
            ),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            label: 'Search',
            hint: 'Search with broker\'s broker name ',
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: BrokerService(uid: currentUser!.uid).readBrokers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                } else if (snapshot.hasData || snapshot.data != null) {
                  documents = snapshot.data!.docs;
                  if (searchText.length > 0) {
                    documents = documents.where((element) {
                      return element
                          .get('brokerName')
                          .toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase());
                    }).toList();
                  }
                  return ListView.separated(
                    reverse: false,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.0),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      //brokers = snapshot.data!.docs;
                      var brokerInfo =
                          documents[index].data() as Map<String, dynamic>;
                      String brokerUid = snapshot.data!.docs[index].id;
                      String brokerName = brokerInfo['brokerName'];
                      String lastName = brokerInfo['lastName'];
                      String brokerType = brokerInfo['brokerType'] ?? '';
                      String gender = brokerInfo['gender'] ?? '';
                      String dob = brokerInfo['dob'] ?? '';
                      String joinedDate = brokerInfo['joinedDate'] ?? '';
                      String schoolType = brokerInfo['schoolType'] ?? '';
                      String logoUrl = brokerInfo['logoUrl'] ?? '';
                      String phone = brokerInfo['phone'] ?? '';
                      String email = brokerInfo['email'] ?? '';
                      String houseNumber = brokerInfo['houseNumber'] ?? '';
                      String street = brokerInfo['street'] ?? '';
                      String city = brokerInfo['city'] ?? '';
                      String state = brokerInfo['state'] ?? '';
                      String country = brokerInfo['country'] ?? '';
                      String timeStamp = brokerInfo['timeStamp'] ?? '';

                      return Ink(
                        decoration: BoxDecoration(
                          color: Palette.firebaseGrey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          /* onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => brokersingleScreen2(
                                brokerName: brokerName.toString(),
                                lastName: lastName.toString(),
                                brokerUid: brokerUid.toString(),
                              ),
                            ),
                          ), */
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => brokersingleScreen(
                                brokerName: brokerName.toString(),
                                lastName: lastName.toString(),
                                brokerUid: brokerUid.toString(),
                                brokerType: brokerType,
                                gender: gender,
                                dob: dob,
                                joinedDate: joinedDate,
                                schoolType: schoolType,
                                logoUrl: logoUrl,
                                phone: phone,
                                email: email,
                                houseNumber: houseNumber,
                                street: street,
                                city: city,
                                state: state,
                                country: country,
                              ),
                            ),
                          ),
                          title: Text(
                            brokerName + ' ' + lastName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                          subtitle: Text(
                            //brokerName,
                            gender + ' ' + '|' + ' ' + brokerType,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              //fontSize: 24,
                              //fontWeight: FontWeight.bold,
                              color: Palette.firebaseGrey,
                              letterSpacing: 2,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '|',
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Palette.firebaseOrange),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add_shopping_cart_sharp,
                                  color: Palette.firebaseYellow,
                                ),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PaymentAddScreenFromBroker(
                                      payerUid: brokerUid,
                                      payerBrokerName: brokerName,
                                      payerLastName: lastName,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit_outlined,
                                  color: Palette.firebaseYellow,
                                ),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BrokerEditScreen(
                                      brokerUid: brokerUid,
                                      currentBrokerName: brokerName,
                                      currentBrokerType: brokerType,
                                      currentJoinedDate: joinedDate,
                                      currentLogoUrl: logoUrl,
                                      currentPhone: phone,
                                      currentEmail: email,
                                      currentCountry: country,
                                      currentTimeStamp: timeStamp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Palette.firebaseOrange,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
