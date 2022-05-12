import 'package:tradelait/signals/screens/signal_add_form.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class SignalAddScreen extends StatelessWidget {
  final FocusNode _entryPriceFocusNode = FocusNode();
  final FocusNode _stopLossFocusNode = FocusNode();
  final FocusNode _currencyPairFocusNode = FocusNode();
  final FocusNode _takeProfit1FocusNode = FocusNode();
  final FocusNode _takeProfit2FocusNode = FocusNode();
  final FocusNode _takeProfit3FocusNode = FocusNode();

  /*  SignalAddScreen({
    Key? key,
    this.currencyPair,
    this.takeProfit1,
  }) : super(key: key);
 */
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
          title: AppBarTitle(
            sectionName: 'Add Signal',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: SignalAddForm(
              entryPriceFocusNode: _entryPriceFocusNode,
              stopLossFocusNode: _stopLossFocusNode,
              currencyPairFocusNode: _currencyPairFocusNode,
              takeProfit1FocusNode: _takeProfit1FocusNode,
              takeProfit2FocusNode: _takeProfit2FocusNode,
              takeProfit3FocusNode: _takeProfit3FocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
