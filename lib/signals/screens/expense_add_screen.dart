import 'package:tradelait/signals/screens/signal_add_form.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class SignalAddScreen extends StatelessWidget {
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _balanceFocusNode = FocusNode();
  final FocusNode _payeeBrokerNameFocusNode = FocusNode();
  final FocusNode _payeeLastNameFocusNode = FocusNode();

  /*  SignalAddScreen({
    Key? key,
    this.payeeBrokerName,
    this.payeeLastName,
  }) : super(key: key);
 */
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _amountFocusNode.unfocus();
        _balanceFocusNode.unfocus();
        _payeeBrokerNameFocusNode.unfocus();
        _payeeLastNameFocusNode.unfocus();
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
              amountFocusNode: _amountFocusNode,
              balanceFocusNode: _balanceFocusNode,
              payeeBrokerNameFocusNode: _payeeBrokerNameFocusNode,
              payeeLastNameFocusNode: _payeeLastNameFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
