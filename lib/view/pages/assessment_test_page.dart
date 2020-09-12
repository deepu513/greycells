import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/assessment/assessment_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/assessment/option.dart';
import 'package:greycells/models/assessment/question.dart';
import 'package:greycells/models/assessment/test.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';

class AssessmentTestPage extends StatefulWidget {
  @override
  _AssessmentTestPageState createState() => _AssessmentTestPageState();
}

class _AssessmentTestPageState extends State<AssessmentTestPage> {
  @override
  void initState() {
    super.initState();
    // TODO: Ask bloc to fetch all questions here
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AssessmentBloc, AssessmentState>(
        listener: (context, state) {},
        child: BlocBuilder<AssessmentBloc, AssessmentState>(
          builder: (context, state) {
            if (state is AssessmentTestLoading) {
              return CenteredCircularLoadingIndicator();
            }
            if (state is ShowQuestion) {
              return _TestSection();
            }
            if (state is AssessmentError) {
              // TODO: Handle error in a different way
              return Container();
            }
            return Container();
          },
        ));
  }
}

class _TestSection extends StatelessWidget {
  final Test test;

  _TestSection(this.test);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        brightness: Brightness.light,
        title: Text(
          "Question ${test.currentQuestion} of ${test.questions.length}}",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
            onPressed: () => showHelpDialog(context),
            icon: Icon(Icons.help_outline),
          )
        ],
      ),
      body: _QuestionOptionPageContent(test.questions[test.currentQuestion]),
    );
  }

  void showHelpDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(Strings.help),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(Strings.assessmentHelp),
                ],
              ),
            ),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}

class _QuestionOptionPageContent extends StatelessWidget {
  final Question question;

  _QuestionOptionPageContent(this.question);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
          child: Text(
            question.questionText,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  height: 1.2,
                  letterSpacing: 0.7,
                ),
          ),
        ),
        Expanded(
          child: OptionSection(question.options, question.answerUpperLimit),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: QuestionNavigator(),
        )
      ],
    );
  }
}

class OptionSection extends StatefulWidget {
  final List<Option> options;
  final int numberOfSelectableOptions;

  OptionSection(this.options, this.numberOfSelectableOptions);

  @override
  _OptionSectionState createState() => _OptionSectionState();
}

class _OptionSectionState extends State<OptionSection> {
  int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = -1;
  }

  // TODO: Make this able to select multiple items
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: index == selectedIndex
                      ? Colors.blueAccent.shade100
                      : Colors.white,
                  border: Border.all(
                      width: selectedIndex >= 0 ? 0.0 : 0.0,
                      color: index == selectedIndex
                          ? Colors.blueAccent.shade100
                          : Colors.transparent),
                  borderRadius: BorderRadius.circular(16.0)),
              child: Text(
                widget.options[index].optionText,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color:
                        index == selectedIndex ? Colors.white : Colors.black),
              ),
            ),
          ),
        );
      },
      itemCount: 6,
    );
  }
}

class QuestionNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            // TODO: Show previous question (should not be editable)
          },
          textColor: Theme.of(context).accentColor,
          child: Text(Strings.back.toUpperCase()),
        ),
        RaisedButton.icon(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          onPressed: () {
            // TODO: Show next question (check if not answered then only editable
          },
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
