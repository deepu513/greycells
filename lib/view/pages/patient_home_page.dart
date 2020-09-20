import 'package:flutter/material.dart';
import 'package:greycells/models/assessment/personality_type.dart';
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
          child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(PersonalityType.values[index].title(),),
                subtitle: Text(PersonalityType.values[index].description()),
                leading: Container(
                  width: 60.0,
                  height: 80.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: PersonalityType.values[index].color()),
                  child: Text(PersonalityType.values[index].initials(), style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w500
                  ),),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: PersonalityType.values.length,
          ),
        ));
  }
}
