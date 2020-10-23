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
              SizedBox(
                height: 24.0,
              ),
              ExpertiseSection(),
              SizedBox(
                height: 16.0,
              ),
              QualificationSection(),
              SizedBox(
                height: 16.0,
              ),
              LanguageSection(),
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

class QualificationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredPageSection(
        sectionColor: Colors.brown.shade50,
        textColor: Colors.brown,
        icon: Icon(
          Icons.school_rounded,
          size: 20.0,
          color: Colors.brown,
        ),
        title: "Qualifications",
        description: "B.Sc Psychology");
  }
}

class LanguageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredPageSection(
        sectionColor: Colors.blueGrey.shade50,
        textColor: Colors.blueGrey,
        icon: Icon(
          Icons.language_rounded,
          size: 20.0,
          color: Colors.blueGrey,
        ),
        title: "Speaks in",
        description: "Hindi, English, Marathi, Tamil");
  }
}

class ExpertiseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          shape: BoxShape.rectangle,
          color: Colors.teal.shade50),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  Icons.adjust_rounded,
                  size: 20.0,
                  color: Colors.teal,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expert in",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.teal, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    SelectableText("Child Psychology",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.teal,
                            )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  Icons.done_all_rounded,
                  size: 20.0,
                  color: Colors.teal,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Specializes in",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.teal, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    SelectableText("Stammering, Lack of confidence, Stage fear",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.teal,
                            ))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ColoredPageSection extends StatelessWidget {
  final Color sectionColor;
  final Color textColor;
  final Widget icon;
  final String title;
  final String description;

  ColoredPageSection(
      {@required this.sectionColor,
      @required this.textColor,
      @required this.icon,
      @required this.title,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          shape: BoxShape.rectangle,
          color: sectionColor),
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: icon),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: textColor, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4.0,
                ),
                SelectableText(description,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontStyle: FontStyle.italic,
                          color: textColor,
                        ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
