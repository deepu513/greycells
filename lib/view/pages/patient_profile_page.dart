import 'package:flutter/material.dart';
import 'package:greycells/models/patient/patient.dart';

class PatientProfilePage extends StatelessWidget {
  final Patient patient;

  PatientProfilePage(this.patient);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProfileHeaderSection(),
              ),
              TabBar(
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        "Personal",
                        style: TextStyle(),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Guardian",
                        style: TextStyle(),
                      ),
                    ),
                  ]),
              Expanded(
                child: Container(
                  child: TabBarView(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PersonalInformation(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GuardianInformation(),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: "profile_pic",
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
            radius: 32.0,
          ),
        ),
        SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Deepak Ramrakhyani",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black87, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.call,
                  size: 14.0,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 4.0,
                ),
                SelectableText(
                  "7666131849",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 14.0),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class PersonalInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // *Email
        ProfileMetaSection(
          metaIcon: Icons.email,
          title: "Email ID",
          description: "dpkramrakhyani@gmail.com",
        ),
        SizedBox(
          height: 16.0,
        ),
        //* Date of birth
        ProfileMetaSection(
          metaIcon: Icons.cake,
          title: "Date of Birth",
          description: "20 April, 2020",
        ),
        SizedBox(
          height: 16.0,
        ),
        // * Gender
        ProfileMetaSection(
          metaIcon: Icons.wc,
          title: "Gender",
          description: "Male",
        ),
        SizedBox(
          height: 16.0,
        ),
        // * Gender
        Row(
          children: [
            //* Height
            Expanded(
              child: ProfileMetaSection(
                metaIcon: Icons.height,
                title: "Height",
                description: "172 cm",
              ),
            ),
            //* Weight
            Expanded(
              child: ProfileMetaSection(
                metaIcon: Icons.settings_input_svideo,
                title: "Weight",
                description: "70 kgs",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16.0,
        ),
        // * Address
        ProfileMetaSection(
          metaIcon: Icons.location_city,
          title: "Contact Address",
          description:
              "31/20, Xyz Street,  ABC Nagar, ABC Nagar, ABC Nagar, Mumbai - 421003",
        ),
      ],
    );
  }
}

class GuardianInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMetaSection(
          metaIcon: Icons.group,
          title: "Relationship",
          description: "Father",
        ),
        SizedBox(
          height: 16.0,
        ),
        ProfileMetaSection(
          metaIcon: Icons.call,
          title: "Contact Number",
          description: "7666131849",
        ),
        SizedBox(
          height: 16.0,
        ),
        ProfileMetaSection(
          metaIcon: Icons.email,
          title: "Email ID",
          description: "dpkramrakhyani@gmail.com",
        ),
        SizedBox(
          height: 16.0,
        ),
        // * Address
        ProfileMetaSection(
          metaIcon: Icons.location_city,
          title: "Contact Address",
          description:
              "31/20, Xyz Street,  ABC Nagar, ABC Nagar, ABC Nagar, Mumbai - 421003",
        ),
      ],
    );
  }
}

class ProfileMetaSection extends StatelessWidget {
  final IconData metaIcon;
  final String title;
  final String description;

  ProfileMetaSection(
      {@required this.metaIcon,
      @required this.title,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          metaIcon,
          size: 20.0,
          color: Colors.grey,
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.subtitle1),
              SizedBox(
                height: 4.0,
              ),
              SelectableText(description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontStyle: FontStyle.italic))
            ],
          ),
        ),
      ],
    );
  }
}
