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
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
            radius: 36.0,
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                Text(
                  "Medical Council",
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
          VerticalDivider(
            thickness: 1.0,
            width: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.purple.shade50),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "5",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.purple, fontWeight: FontWeight.w700),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "years",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black87, fontStyle: FontStyle.italic),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "exp",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black87, fontStyle: FontStyle.italic),
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          )
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
