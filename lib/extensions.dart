import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/bloc/validation/validation_field.dart';

extension Validation on ValidationState {
  bool isFieldInvalid(ValidationField field) =>
      this is ValidationInvalidField &&
      (this as ValidationInvalidField).field == field;
}

extension StringExtensions on String {
  bool isNullOrEmpty() =>
      this == null ? true : this != null && this.trim().isEmpty;

  bool hasRequiredLength(int length) =>
      this != null && this.isNotEmpty && this.length == length;

  String get titleCase => '${this[0].toUpperCase()}${this.substring(1)}';
}

extension dialogs on Widget {
  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text("Error"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(errorMessage),
                ],
              ),
            ),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}

extension NumberToWord on int {
  String toWord() {
    if (this == 1) return "First";
    if (this == 2) return "Second";
    if (this == 3) return "Third";
    if (this == 4) return "Four";
    if (this == 5) return "Five";
    return "";
  }
}
