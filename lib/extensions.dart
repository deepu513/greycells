import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/bloc/validation/validation_field.dart';

import 'constants/strings.dart';

extension Validation on ValidationState {
  bool isFieldInvalid(ValidationField field) =>
      this is ValidationInvalidField &&
      (this as ValidationInvalidField).field == field;
}

extension StringExtensions on String {
  bool isNullOrEmpty() =>
      this == null ? true : this != null && this.trim().isEmpty;

  bool hasRequiredLength(int length) =>
      this != null && this.isNotEmpty && this.length >= length;

  String get titleCase => '${this[0].toUpperCase()}${this.substring(1)}';
}

extension dialogs on Widget {
  _showDialog(
      {@required BuildContext context,
      @required String title,
      @required String message,
      Icon icon,
      @required VoidCallback onPressed}) {
    showModal(
        context: context,
        configuration: FadeScaleTransitionConfiguration(),
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Visibility(
                    visible: icon != null,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: icon,
                    )),
                Text(title),
              ],
            ),
            content: SingleChildScrollView(
              child: Text(message),
            ),
            actions: [
              FlatButton(
                child: Text(Strings.ok.toUpperCase()),
                onPressed: onPressed,
              )
            ],
          );
        });
  }

  void showErrorDialog(
      {@required BuildContext context,
      @required String message,
      @required bool showIcon,
      @required VoidCallback onPressed}) {
    _showDialog(
        context: context,
        title: Strings.error,
        message: message,
        icon: showIcon
            ? Icon(
                Icons.error_outline,
                color: Colors.red,
              )
            : null,
        onPressed: onPressed);
  }

  void showHelpDialog(
      {@required BuildContext context,
      @required String message,
      @required bool showIcon,
      @required VoidCallback onPressed}) {
    _showDialog(
        context: context,
        title: Strings.help,
        message: message,
        icon: showIcon
            ? Icon(
                Icons.help_outline,
                color: Colors.yellow,
              )
            : null,
        onPressed: onPressed);
  }

  void showSuccessDialog(
      {@required BuildContext context,
      @required String message,
      @required bool showIcon,
      @required VoidCallback onPressed}) {
    _showDialog(
        context: context,
        title: Strings.success,
        message: message,
        icon: showIcon
            ? Icon(
                Icons.done,
                color: Colors.green,
              )
            : null,
        onPressed: onPressed);
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
