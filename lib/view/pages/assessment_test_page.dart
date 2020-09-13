import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/assessment/assessment_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/models/assessment/option.dart';
import 'package:greycells/models/assessment/question.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';

// TODO: SharedPrefs mein save karo
class AssessmentTestPage extends StatefulWidget {
  final int testNumber;

  AssessmentTestPage(this.testNumber);

  @override
  _AssessmentTestPageState createState() => _AssessmentTestPageState();
}

class _AssessmentTestPageState extends State<AssessmentTestPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AssessmentBloc>(context).add(LoadAssessmentTest());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AssessmentBloc, AssessmentState>(
      listener: (context, state) {
        if (state is AssessmentError) {
          widget.showErrorDialog(context, ErrorMessages.GENERIC_ERROR_MESSAGE);
        }
        if (state is ErrorWhileSavingSelectedOption) {
          widget.showErrorDialog(context, Strings.optionSubmitError);
        }
        if (state is TestComplete) {
          if (state.testId == 1) {
            // Start Test 2
            Navigator.of(context).pushNamedAndRemoveUntil(
                RouteName.SECOND_TEST_INTRO, (route) => false);
          } else if (state.testId == 2) {
            // Navigate to home
            Navigator.of(context)
                .pushNamedAndRemoveUntil(RouteName.HOME, (route) => false);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 4.0,
          brightness: Brightness.light,
          title: Text(
            "Test ${widget.testNumber} of 2",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(
              onPressed: () =>
                  widget.showHelpDialog(context, Strings.assessmentHelp),
              icon: Icon(Icons.help_outline),
            )
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<AssessmentBloc, AssessmentState>(
            buildWhen: (previous, current) =>
                current is AssessmentTestLoading ||
                current is ShowQuestion ||
                current is OptionSelected ||
                current is OptionDeselected ||
                current is SavingSelectedOption ||
                current is ErrorWhileSavingSelectedOption,
            builder: (context, state) {
              if (state is AssessmentTestLoading) {
                return CenteredCircularLoadingIndicator();
              }
              if (state is ShowQuestion) {
                return _TestPageContent(
                    state.currentQuestion, state.totalQuestions);
              }
              if (state is OptionSelected) {
                return _TestPageContent(
                    state.currentQuestion, state.totalQuestions);
              }
              if (state is OptionDeselected) {
                return _TestPageContent(
                    state.currentQuestion, state.totalQuestions);
              }
              if (state is SavingSelectedOption) {
                return _TestPageContent(
                    state.currentQuestion, state.totalQuestions);
              }
              if (state is ErrorWhileSavingSelectedOption) {
                return _TestPageContent(
                    state.currentQuestion, state.totalQuestions);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class _TestPageContent extends StatelessWidget {
  final Question question;
  final int _totalQuestions;

  _TestPageContent(this.question, this._totalQuestions);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Text(
            "# Question ${question.sequence} of $_totalQuestions",
            style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          child: Text(
            question.questionText,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  height: 1.2,
                  letterSpacing: 0.7,
                ),
          ),
        ),
        Expanded(
          child: OptionSection(question.options, question.answered),
        ),
        Visibility(
          visible: question.answered == false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16.0,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 4.0),
                Text(
                  question.answerUpperLimit > 1
                      ? Strings.multiOptionHelper
                      : Strings.optionHelper,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: QuestionNavigator(
              question.answered || question.selectedOptions.isNotEmpty),
        )
      ],
    );
  }
}

class OptionSection extends StatelessWidget {
  final List<Option> options;
  final bool answered;

  OptionSection(this.options, this.answered);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: GestureDetector(
            onTap: () {
              if (!answered)
                BlocProvider.of<AssessmentBloc>(context)
                    .add(TrySelectingOption(options[index]));
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: options[index].selected
                    ? Colors.blueAccent.shade100
                    : Colors.white,
                border: Border.all(
                    width: options[index].selected ? 0.0 : 0.5,
                    color: options[index].selected
                        ? Colors.blueAccent.shade100
                        : answered ? Colors.transparent : Colors.black),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                options[index].optionText.titleCase,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color:
                        options[index].selected ? Colors.white : Colors.black),
              ),
            ),
          ),
        );
      },
      itemCount: options.length,
    );
  }
}

class QuestionNavigator extends StatelessWidget {
  final bool enableNextButton;

  QuestionNavigator(this.enableNextButton);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            BlocProvider.of<AssessmentBloc>(context)
                .add(ShowPreviousQuestion());
          },
          textColor: Theme.of(context).accentColor,
          child: Text(Strings.back.toUpperCase()),
        ),
        RaisedButton.icon(
          onPressed: true
              ? () {
                  BlocProvider.of<AssessmentBloc>(context)
                      .add(QuestionAnswered());
                }
              : null,
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          icon: Icon(
            Icons.save,
            color: Colors.white,
            size: 20.0,
          ),
          label: Text(
            Strings.saveAndNext.toUpperCase(),
          ),
        )
      ],
    );
  }
}
