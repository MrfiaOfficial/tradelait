// Modal Pop Up WIdget

import 'package:flutter/material.dart';

class ModalPopUp extends StatelessWidget {
  final String modalTitle;
  final String modalDescription;
  const ModalPopUp(
      {Key? key, required this.modalTitle, required this.modalDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(modalTitle),
          ),
          SizedBox(height: 10.0),
          Container(
            child: Text(modalDescription),
          ),
        ],
      ),
    );
  }
}
