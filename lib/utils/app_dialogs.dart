import 'package:flutter/material.dart';

class CustomOKActionButton extends StatelessWidget {
  final String title;
  final String message;
  final String positiveLabel;
  final String negativeLabel;
  final Function positiveFunction;
  final Function negativeFunction;

  CustomOKActionButton({
    required this.title,
    required this.message,
    required this.positiveLabel,
    required this.negativeLabel,
    required this.positiveFunction,
    required this.negativeFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
      ),
      content: Text(message),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: negativeLabel != ""
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Text(positiveLabel),
                onPressed: () {
                  positiveFunction();
                  Navigator.of(context).pop();
                },
              ),
              Visibility(
                visible: negativeLabel != "",
                child: TextButton(
                  child: Text(negativeLabel),
                  onPressed: () {
                    negativeFunction();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
