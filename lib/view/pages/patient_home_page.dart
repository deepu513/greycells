import 'package:flutter/material.dart';
import 'package:greycells/constants/strings.dart';
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
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 0.0),
                    child: Text(
                      Strings.scores,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Card(
                    elevation: 3.0,
                    margin: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              children: [
                                Text(
                                  Strings.firstTest,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                    homeData.behaviourScore
                                        .fold(
                                            0,
                                            (previousValue, element) =>
                                                previousValue + element.score)
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 48.0,
                          child: VerticalDivider(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              children: [
                                Text(Strings.secondTest,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                    homeData.personalityScore
                                        .fold(
                                            "",
                                            (previousValue, element) =>
                                                previousValue +
                                                element.groupName +
                                                " ")
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.headline5)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              /*SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: homeData.behaviourScore.length,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Column(
                    children: [
                      Text(homeData.behaviourScore[index].groupName),
                      Text(homeData.behaviourScore[index].score.toString()),
                    ],
                  );
                }, childCount: homeData.behaviourScore.length),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: homeData.personalityScore.length,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Column(
                    children: [
                      Text(homeData.personalityScore[index].groupName),
                      Text(homeData.personalityScore[index].score.toString()),
                    ],
                  );
                }, childCount: homeData.personalityScore.length),
              )*/
            ],
          ),
        ));
  }
}
