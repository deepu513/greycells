import 'package:flutter/material.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/route/route_name.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
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
                    Divider(
                      height: 32.0,
                    ),
                    MeetingChargesSection(),
                  ],
                ),
              ),
            ),
            BookAppointmentButton(),
          ],
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
          Hero(
            tag: "profile_pic 1",
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
              radius: 36.0,
            ),
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Hero(
              tag: "therapist_meta 1",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
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
          ),
          VerticalDivider(
            thickness: 1.0,
            width: 24.0,
            indent: 4.0,
            endIndent: 4.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: "therapist_exp 1",
                  child: Container(
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
          PageSection(
            textColor: Colors.teal,
            icon: Icon(
              Icons.adjust_rounded,
              size: 20.0,
              color: Colors.teal,
            ),
            title: "Expert in",
            description: "Child Psychology",
          ),
          SizedBox(height: 16.0),
          PageSection(
            textColor: Colors.teal,
            icon: Icon(
              Icons.done_all_rounded,
              size: 20.0,
              color: Colors.teal,
            ),
            title: "Specializes in",
            description: "Stammering, Lack of confidence, Stage fear",
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
      child: PageSection(
        textColor: textColor,
        icon: icon,
        title: title,
        description: description,
      ),
    );
  }
}

class PageSection extends StatelessWidget {
  final Color textColor;
  final Widget icon;
  final String title;
  final String description;

  PageSection(
      {@required this.textColor,
      @required this.icon,
      @required this.title,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), child: icon),
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
    );
  }
}

class MeetingChargesSection extends StatefulWidget {
  @override
  _MeetingChargesSectionState createState() => _MeetingChargesSectionState();
}

class _MeetingChargesSectionState extends State<MeetingChargesSection> {
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Meeting charges",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w700, color: Colors.black87),
              ),
              Spacer(),
              RichText(
                text: TextSpan(
                    text: "Duration: ",
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                    children: [
                      TextSpan(
                          text: "60 minutes",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontWeight: FontWeight.w700))
                    ]),
              )
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          ListView.separated(
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color:
                        _selectedIndex == index ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _selectedIndex == index
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.black38,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "One to One",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.black87),
                      ),
                      Spacer(),
                      Text(
                        Strings.rupeeSymbol + "1000",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.black87),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 16.0,
              );
            },
          )
        ],
      ),
    );
  }
}

class BookAppointmentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(RouteName.APPOINTMENT_DATE_SELECTION_PAGE);
        },
        color: Theme.of(context).primaryColor,
        height: 56.0,
        minWidth: double.maxFinite,
        child: Text(
          "Book an appointment".toUpperCase(),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                wordSpacing: 1.0,
                letterSpacing: 0.75,
                color: Colors.white,
              ),
        ));
  }
}
