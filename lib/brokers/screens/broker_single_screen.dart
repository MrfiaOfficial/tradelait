import 'dart:ui';
import 'package:tradelait/payments/screens/payment_frombroker2_list_screen.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/brokers/screens/broker_edit_screen.dart';
import 'package:tradelait/brokers/services/broker_service.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../users/models/user_model.dart';

class brokersingleScreen extends StatefulWidget {
  final String brokerUid;
  final String brokerName;
  final String lastName;
  final String brokerType;
  final String gender;
  final String dob;
  final String joinedDate;
  final String schoolType;
  final String logoUrl;
  final String phone;
  final String email;
  final String houseNumber;
  final String street;
  final String city;
  final String state;
  final String country;
  const brokersingleScreen({
    required this.brokerName,
    required this.lastName,
    required this.brokerUid,
    required this.brokerType,
    required this.gender,
    required this.dob,
    required this.joinedDate,
    required this.schoolType,
    required this.logoUrl,
    required this.phone,
    required this.email,
    required this.houseNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    Key? key,
  }) : super(key: key);

  @override
  _brokersingleScreenState createState() => _brokersingleScreenState();
}

class _brokersingleScreenState extends State<brokersingleScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: widget.brokerName + ' ' + widget.lastName,
        ),
      ),
      //backgroundColor: ArgonColors.bgColorScreen,
      //backgroundColor: Palette.firebaseYellow,
      //drawer: ArgonDrawer(currentPage: "broker Profile"),
      body: StreamBuilder<DocumentSnapshot>(
        stream: BrokerService(uid: currentUser!.uid)
            .readSingleBroker(widget.brokerUid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            var brokerInfo = snapshot.data!.data() as Map<String, dynamic>;
            String brokerUid = snapshot.data!.id;
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

            return Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Stack(
                children: <Widget>[
                  SafeArea(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 74.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: <Widget>[
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 5,
                                      //color: Palette.firebaseYellow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 85.0, bottom: 20.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 40.0),
                                                  Align(
                                                    child: Text(
                                                      brokerName +
                                                          " " +
                                                          lastName,
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 28.0),
                                                    ),
                                                  ),
                                                  /* SizedBox(height: 10.0),
                                              Align(
                                                child: Text(
                                                  widget.lastName,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                              ), */
                                                  Divider(
                                                    height: 40.0,
                                                    thickness: 1.5,
                                                    indent: 32.0,
                                                    endIndent: 32.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 32.0,
                                                            right: 32.0),
                                                    child: Align(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            brokerType +
                                                                ' ' +
                                                                '|' +
                                                                ' ' +
                                                                schoolType,
                                                            //"${loggedInUser.phoneNumber} ?? '",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        82,
                                                                        95,
                                                                        127,
                                                                        1),
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
                                                          ),
                                                          Text(
                                                            gender,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        82,
                                                                        95,
                                                                        127,
                                                                        1),
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Align(
                                                    child: TextButton(
                                                      child: Text(
                                                        'All Payments',
                                                        style: TextStyle(
                                                            fontSize: 17),
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PaymentListScreenFromBroker2(
                                                            brokerUid:
                                                                brokerUid,
                                                            brokerName:
                                                                brokerName
                                                                    .toString(),
                                                            lastName: lastName
                                                                .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 25.0),
                                                  SizedBox(height: 25.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 25.0,
                                                            left: 25.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.edit_outlined,
                                                            color: Palette
                                                                .firebaseNavy,
                                                          ),
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  brokerEditScreen(
                                                                brokerUid:
                                                                    brokerUid,
                                                                currentBrokerName:
                                                                    brokerName,
                                                                currentLastName:
                                                                    lastName,
                                                                currentbrokerType:
                                                                    brokerType,
                                                                currentGender:
                                                                    gender,
                                                                currentDob: dob,
                                                                currentJoinedDate:
                                                                    joinedDate,
                                                                currentSchoolType:
                                                                    schoolType,
                                                                currentLogoUrl:
                                                                    logoUrl,
                                                                currentPhone:
                                                                    phone,
                                                                currentEmail:
                                                                    email,
                                                                currentHouseNumber:
                                                                    houseNumber,
                                                                currentStreet:
                                                                    street,
                                                                currentCity:
                                                                    city,
                                                                currentState:
                                                                    state,
                                                                currentCountry:
                                                                    country,
                                                                currentTimeStamp:
                                                                    timeStamp,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        /* IconButton(
                                                      icon: Icon(
                                                        Icons.delete_rounded,
                                                        color:
                                                            Palette.firebaseNavy,
                                                      ),
                                                      onPressed: () async {
                                                        await brokerservice(
                                                                uid: currentUser!
                                                                    .uid)
                                                            .deletebroker(
                                                                brokerUid: widget
                                                                    .brokerUid);
                                                        Navigator.of(context).pop;
                                                      },
                                                    ), */
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  FractionalTranslation(
                                    translation: Offset(0.0, -0.5),
                                    child: Align(
                                      child: CircleAvatar(
                                        backgroundImage:
                                            AssetImage("assets/logo.png"),
                                        radius: 65.0,
                                        backgroundColor: Palette.firebaseNavy,
                                        // maxRadius: 200.0,
                                      ),
                                      alignment: FractionalOffset(0.5, 0.0),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
    );
  }
}
