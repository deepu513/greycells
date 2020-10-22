import 'package:flutter/material.dart';

class TherapistProfilePage extends StatelessWidget {
  const TherapistProfilePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
        elevation: 4.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(),
              LanguageSection(),
              ExpertiseSection(),
              SpecialisationSection()
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
              radius: 32.0,
            ),
            SizedBox(
              width: 16.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr. Anne Hathaway",
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "Clinical Psychologist",
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
            Spacer(),
            OutlinedChip(
              icon: Icon(
                Icons.work,
                color: Colors.black87,
                size: 12.0,
              ),
              text: Text(
                "5 years exp",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.black87),
                overflow: TextOverflow.clip,
              ),
              borderColor: Colors.black38,
            ),
          ],
        ),
        SizedBox(
          height: 16.0,
        ),
        OutlinedChip(
          icon: Icon(
            Icons.school,
            size: 14.0,
            color: Colors.brown,
          ),
          text: Text(
            "B.Sc. Psychology",
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.brown),
          ),
          borderColor: Colors.brown.shade200,
        ),
      ],
    );
  }
}

class OutlinedChip extends StatelessWidget {
  final Widget icon;
  final Widget text;
  final Color borderColor;

  OutlinedChip(
      {@required this.icon, @required this.text, @required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(
            width: 4.0,
          ),
          text
        ],
      ),
    );
  }
}

class LanguageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ExpertiseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SpecialisationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
