import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/authentication/forgot_password_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/view/widgets/title_with_loading.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email;

  @override
  void initState() {
    super.initState();
    email = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is EmailSent) {
              widget.showSuccessDialog(
                  context: context,
                  message: Strings.forgotPasswordSuccess,
                  showIcon: true,
                  onPressed: () async {
                    Navigator.of(context).pop();
                  });
            }
            if (state is ForgotPasswordError) {
              widget.showErrorDialog(
                  context: context,
                  message: state.error,
                  showIcon: true,
                  onPressed: () async {
                    Navigator.of(context).pop();
                  });
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleWithLoading(
                  text: Text(
                    Strings.forgotPasswordTitle,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.w400),
                  ),
                  loadingVisibility: state is SendingEmail,
                  loadingBackgroundColor: Colors.white,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(Strings.resetPasswordMessage,
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(
                  height: 56.0,
                ),
                TextField(
                  maxLines: 1,
                  style: TextStyle(fontSize: 18.0),
                  enabled: state is! SendingEmail,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.alternate_email,
                        size: 20.0,
                      ),
                      helperText: Strings.tapToEnter,
                      labelText: Strings.email,
                      contentPadding: EdgeInsets.zero,
                      errorText: state is InvalidEmail
                          ? "Please enter your email"
                          : null),
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => email = value,
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                    BlocProvider.of<ForgotPasswordBloc>(context)
                        .add(RequestSendEmail(email));
                  },
                ),
                SizedBox(
                  height: 48.0,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 48.0,
                  child: RaisedButton(
                    onPressed: state is SendingEmail
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            BlocProvider.of<ForgotPasswordBloc>(context)
                                .add(RequestSendEmail(email));
                          },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      Strings.confirm.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
