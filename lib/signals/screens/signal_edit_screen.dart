import 'package:tradelait/signals/screens/signal_edit_form.dart';
import 'package:tradelait/signals/services/signal_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class SignalEditScreen extends StatefulWidget {
  final String signalUid;
  final String currentSignalType;
  final String currentCurrencyPair;
  final String currentOrderType;
  final String currentEntryPrice;
  final String currentTimeFrame;
  final String currentTakeProfit1;
  final String currentTakeProfit2;
  final String currentTakeProfit3;
  final String currentStopLoss;
  final String currentDate;
  final String createdTimeStamp;

  SignalEditScreen({
    required this.signalUid,
    required this.currentSignalType,
    required this.currentCurrencyPair,
    required this.currentOrderType,
    required this.currentEntryPrice,
    required this.currentTimeFrame,
    required this.currentTakeProfit1,
    required this.currentTakeProfit2,
    required this.currentTakeProfit3,
    required this.currentStopLoss,
    required this.currentDate,
    required this.createdTimeStamp,
  });

  @override
  _SignalEditScreenState createState() => _SignalEditScreenState();
}

class _SignalEditScreenState extends State<SignalEditScreen> {
  final FocusNode _entryPriceFocusNode = FocusNode();
  final FocusNode _stopLossFocusNode = FocusNode();
  final FocusNode _currencyPairFocusNode = FocusNode();
  final FocusNode _takeProfit1FocusNode = FocusNode();
  final FocusNode _takeProfit2FocusNode = FocusNode();
  final FocusNode _takeProfit3FocusNode = FocusNode();

  bool _isDeleting = false;
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _entryPriceFocusNode.unfocus();
        _stopLossFocusNode.unfocus();
        _currencyPairFocusNode.unfocus();
        _takeProfit1FocusNode.unfocus();
        _takeProfit2FocusNode.unfocus();
        _takeProfit3FocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(sectionName: 'Edit Signal'),
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

                      await SignalService(uid: currentUser!.uid).deleteSignal(
                        signalUid: widget.signalUid,
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
            child: SignalEditForm(
              entryPriceFocusNode: _entryPriceFocusNode,
              stopLossFocusNode: _stopLossFocusNode,
              currencyPairFocusNode: _currencyPairFocusNode,
              takeProfit1FocusNode: _takeProfit1FocusNode,
              takeProfit2FocusNode: _takeProfit2FocusNode,
              takeProfit3FocusNode: _takeProfit3FocusNode,
              //
              signalUid: widget.signalUid,
              currentSignalType: widget.currentSignalType,
              currentCurrencyPair: widget.currentCurrencyPair,
              currentOrderType: widget.currentOrderType,
              currentEntryPrice: widget.currentEntryPrice,
              currentTimeFrame: widget.currentTimeFrame,
              currentTakeProfit1: widget.currentTakeProfit1,
              currentTakeProfit2: widget.currentTakeProfit2,
              currentTakeProfit3: widget.currentTakeProfit3,
              currentStopLoss: widget.currentStopLoss,
              currentDate: widget.currentDate,
              createdTimeStamp: widget.createdTimeStamp,
            ),
          ),
        ),
      ),
    );
  }
}
