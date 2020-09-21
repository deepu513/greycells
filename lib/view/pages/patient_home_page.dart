import 'package:flutter/material.dart';
import 'package:greycells/models/assessment/personality_type.dart';
import 'package:greycells/models/assessment/score.dart';
import 'package:greycells/models/home/home.dart';
import 'package:provider/provider.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  Home homeData;

  @override
  void initState() {
    super.initState();
    homeData = Provider.of<Home>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          elevation: 4.0,
          brightness: Brightness.light,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Your personality type"),
                      SizedBox(
                        width: 16.0,
                      ),
                      ...getLetterBoxesForPersonality(
                          homeData.personalityScore),
                    ],
                  )),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "All personality types",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                          PersonalityType.values[index].title(),
                        ),
                        subtitle:
                            Text(PersonalityType.values[index].description()),
                        leading: letterBox(
                            PersonalityType.values[index].initials(),
                            PersonalityType.values[index].color()));
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: PersonalityType.values.length,
                ),
              ),
            ],
          ),
        ));
  }

  List<Widget> getLetterBoxesForPersonality(List<Score> receivedScore) {
    List<Widget> letterBoxes = List();
    List<PersonalityType> personalityTypes = PersonalityType.values;
    for (int i = 0; i < receivedScore.length; i++) {
      PersonalityType type = personalityTypes.firstWhere(
          (element) => element.initials() == receivedScore[i].groupName);
      letterBoxes.add(letterBox(type.initials(), type.color(), width: 35.0, height: 35.0));
      letterBoxes.add(SizedBox(width: 8.0,));
    }
    return letterBoxes;
  }

  Widget letterBox(String letter, Color boxColor,
      {double width = 60.0, double height = 80.0}) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: boxColor),
      child: Text(
        letter,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
