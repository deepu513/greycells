import 'package:flutter/material.dart';
import 'package:greycells/constants/gender.dart';
import 'package:greycells/models/patient/guardian/guardian.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/view/widgets/circle_avatar_or_initials.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/view/widgets/colored_page_section.dart';
import 'package:greycells/view/widgets/page_section.dart';

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
                child: ProfileHeaderSection(patient),
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
                      child: PersonalInformation(
                        patient: patient,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GuardianInformation(
                        guardian: patient.guardian,
                      ),
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
  final Patient patient;
  ProfileHeaderSection(this.patient);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: "profile_pic",
          child: CircleAvatarOrInitials(
            radius: 32.0,
            imageUrl: patient.file != null
                ? patient.file.name.withBaseUrlForImage()
                : "",
            stringForInitials: patient.fullName,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patient.fullName,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 4.0,
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.call_rounded,
                    size: 14.0,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  SelectableText(patient.user.mobileNumber,
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.alternate_email_rounded,
                    size: 14.0,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  SelectableText(patient.user.email,
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PersonalInformation extends StatelessWidget {
  final Patient patient;

  const PersonalInformation({Key key, @required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ColoredPageSection(
            icon: Icon(
              Icons.cake_rounded,
              color: Colors.blueGrey,
            ),
            description: patient.dateOfBirth,
            title: "Date of Birth",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: false,
          ),
          //* Date of birth
          SizedBox(
            height: 16.0,
          ),
          // * Gender
          ColoredPageSection(
            icon: Icon(
              Icons.wc_rounded,
              color: Colors.blueGrey,
            ),
            description: Gender.values()[patient.genderValue].toString(),
            title: "Gender",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: false,
          ),
          SizedBox(
            height: 16.0,
          ),
          // * Gender
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              shape: BoxShape.rectangle,
              color: Colors.grey.shade50,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PageSection(
                  textColor: Colors.blueGrey,
                  icon: Icon(
                    Icons.height,
                    color: Colors.blueGrey,
                  ),
                  title: "Height",
                  description:
                      "${patient.healthRecord.heightInCm.toString()} cms",
                  descriptionIsItalic: false,
                ),
                SizedBox(
                  height: 24.0,
                ),
                PageSection(
                  textColor: Colors.blueGrey,
                  icon: Icon(
                    Icons.settings_input_svideo,
                    color: Colors.blueGrey,
                  ),
                  title: "Weight",
                  description:
                      "${patient.healthRecord.weightInKg.toString()} kgs",
                  descriptionIsItalic: false,
                ),
              ],
            ),
          ),

          SizedBox(
            height: 16.0,
          ),
          // * Address
          ColoredPageSection(
            icon: Icon(
              Icons.location_city,
              color: Colors.blueGrey,
            ),
            description: patient.address.readableAddress,
            title: "Contact Address",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: false,
          ),
        ],
      ),
    );
  }
}

class GuardianInformation extends StatelessWidget {
  final Guardian guardian;

  const GuardianInformation({Key key, @required this.guardian})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ColoredPageSection(
            icon: Icon(
              Icons.group_rounded,
              color: Colors.blueGrey,
            ),
            description: guardian.readableRelationship,
            title: "Relationship",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: false,
          ),
          SizedBox(
            height: 16.0,
          ),
          ColoredPageSection(
            icon: Icon(
              Icons.call_rounded,
              color: Colors.blueGrey,
            ),
            description: guardian.mobileNumber,
            title: "Contact Number",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: false,
          ),
          SizedBox(
            height: 16.0,
          ),
          ColoredPageSection(
            icon: Icon(
              Icons.alternate_email_rounded,
              color: Colors.blueGrey,
            ),
            description: guardian.email.isNullOrEmpty()
                ? "not available"
                : guardian.email,
            title: "Email ID",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: guardian.email.isNullOrEmpty(),
          ),
          SizedBox(
            height: 16.0,
          ),
          // * Address
          ColoredPageSection(
            icon: Icon(
              Icons.location_city_rounded,
              color: Colors.blueGrey,
            ),
            description: guardian.address == null
                ? "not available"
                : guardian.address.readableAddress,
            title: "Contact Address",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: guardian.address == null,
          ),
        ],
      ),
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
