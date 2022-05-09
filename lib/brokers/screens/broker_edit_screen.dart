import 'package:tradelait/brokers/screens/broker_edit_form.dart';
import 'package:tradelait/brokers/services/broker_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class BrokerEditScreen extends StatefulWidget {
  final String currentBrokerName;
  final String currentBrokerType;
  final String currentJoinedDate;
  final String currentLogoUrl;
  final String currentPhone;
  final String currentEmail;
  final String currentCountry;
  final String currentTimeStamp;
  final String brokerUid;

  BrokerEditScreen({
    required this.currentBrokerName,
    required this.currentBrokerType,
    required this.currentPhone,
    required this.currentEmail,
    required this.currentJoinedDate,
    required this.currentLogoUrl,
    required this.currentCountry,
    required this.currentTimeStamp,
    required this.brokerUid,
  });

  @override
  _BrokerEditScreenState createState() => _BrokerEditScreenState();
}

class _BrokerEditScreenState extends State<BrokerEditScreen> {
  final FocusNode _brokerNameFocusNode = FocusNode();
  final FocusNode _joinedDateFocusNode = FocusNode();
  final FocusNode _logoUrlFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();

  bool _isDeleting = false;
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _brokerNameFocusNode.unfocus();
          _phoneFocusNode.unfocus();
          _emailFocusNode.unfocus();
          _joinedDateFocusNode.unfocus();
          _logoUrlFocusNode.unfocus();
          _countryFocusNode.unfocus();
        },
        child: Scaffold(
          backgroundColor: Palette.firebaseNavy,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Palette.firebaseNavy,
            title: AppBarTitle(
              sectionName: 'Edit : ' + widget.currentBrokerName,
            ),
            actions: [
              _isDeleting
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        right: 16.0,
                      ),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.redAccent,
                        ),
                        strokeWidth: 3,
                      ),
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                        size: 32,
                      ),
                      onPressed: () async {
                        setState(() {
                          _isDeleting = true;
                        });

                        await BrokerService(uid: currentUser!.uid).deleteBroker(
                          brokerUid: widget.brokerUid,
                        );

                        setState(() {
                          _isDeleting = false;
                        });

                        Navigator.of(context).pop();
                      },
                    ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 20.0,
              ),
              child: BrokerEditForm(
                currentBrokerNameFocusNode: _brokerNameFocusNode,
                currentJoinedDateFocusNode: _joinedDateFocusNode,
                currentLogoUrlFocusNode: _logoUrlFocusNode,
                currentPhoneFocusNode: _phoneFocusNode,
                currentEmailFocusNode: _emailFocusNode,
                currentCountryFocusNode: _countryFocusNode,
                //
                brokerUid: widget.brokerUid,
                currentBrokerName: widget.currentBrokerName,
                currentBrokerType: widget.currentBrokerType,
                currentJoinedDate: widget.currentJoinedDate,
                currentLogoUrl: widget.currentLogoUrl,
                currentPhone: widget.currentPhone,
                currentEmail: widget.currentEmail,
                currentCountry: widget.currentCountry,
                currentTimeStamp: widget.currentTimeStamp,
              ),
            ),
          ),
        ));
  }
}
