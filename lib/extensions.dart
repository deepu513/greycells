import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/bloc/validation/validation_field.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/models/therapist/therapist.dart';
import 'package:intl/intl.dart';

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

  String convertToDateFormat(String format) {
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      DateTime dateTime = dateFormat.parse(this);
      return DateFormat(format).format(dateTime);
    } catch (e) {
      print(e);
    }
    return "";
  }

  String withBaseUrlForImage() {
    if (this.isEmpty) return "";
    return "https://www.greycellswellness.com/File/$this";
  }

  String initials() {
    if (this.isNullOrEmpty()) return "";
    String initials = "";
    this.split(" ").forEach((splitString) {
      initials += splitString[0];
    });
    return initials;
  }

  DateTime serverTimestampAsDate() =>
      DateFormat("dd-MM-yyyy HH:mm:ss a").parse(this);

  DateTime asDate() => DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(this);

  DateTime timeAsDate() => DateFormat("h:mm a").parse(this);
}

extension DateTimeExtensions on DateTime {
  String formatToddMMyyyy() {
    try {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      return dateFormat.format(this);
    } catch (e) {
      print(e);
    }
    return "";
  }

  String readableDate() {
    try {
      DateFormat dateFormat = DateFormat("EEE, dd MMM, yyyy");
      return dateFormat.format(this);
    } catch (e) {
      print(e);
    }
    return "";
  }
}

extension TherapistExtension on Therapist {
  String get fullName =>
      "${this.user.firstName.trim()} ${this.user.lastName.trim()}";
}

extension PatientExtension on Patient {
  String get fullName =>
      "${this.user.firstName.trim()} ${this.user.lastName.trim()}";
}

extension dialogs on Widget {
  Future<T> _showDialog<T>(
      {@required BuildContext context,
      @required String title,
      @required String message,
      Icon icon,
      @required VoidCallback onPressed}) {
    return showModal(
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

  Future<T> showErrorDialog<T>(
      {@required BuildContext context,
      @required String message,
      @required bool showIcon,
      @required VoidCallback onPressed}) {
    return _showDialog(
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

  Future<T> showHelpDialog<T>(
      {@required BuildContext context,
      @required String message,
      @required bool showIcon,
      @required VoidCallback onPressed}) {
    return _showDialog(
        context: context,
        title: Strings.info,
        message: message,
        icon: showIcon
            ? Icon(
                Icons.help_outline,
                color: Colors.yellow,
              )
            : null,
        onPressed: onPressed);
  }

  Future<T> showSuccessDialog<T>(
      {@required BuildContext context,
      @required String message,
      @required bool showIcon,
      @required VoidCallback onPressed}) {
    return _showDialog(
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

  Future<T> showConfirmationDialog<T>(
      {@required BuildContext context,
      @required String message,
      @required VoidCallback onConfirmed,
      @required VoidCallback onCancelled}) {
    return showModal(
        context: context,
        configuration: FadeScaleTransitionConfiguration(),
        builder: (context) {
          return AlertDialog(
            title: Text("${Strings.confirm}?"),
            content: SingleChildScrollView(
              child: Text(message),
            ),
            actions: [
              FlatButton(
                child: Text(
                  Strings.cancel.toUpperCase(),
                  textAlign: TextAlign.end,
                ),
                onPressed: onCancelled,
              ),
              FlatButton(
                child: Text(
                  Strings.confirm.toUpperCase(),
                  textAlign: TextAlign.end,
                ),
                onPressed: onConfirmed,
              ),
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
