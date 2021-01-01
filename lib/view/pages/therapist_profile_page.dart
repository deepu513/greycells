import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/patient/eligibility_check_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/appointment/appointment_date_args.dart';
import 'package:greycells/models/therapist/charge.dart';
import 'package:greycells/models/therapist/disorder.dart';
import 'package:greycells/models/therapist/therapist.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/view/widgets/circle_avatar_or_initials.dart';
import 'package:greycells/view/widgets/colored_page_section.dart';
import 'package:greycells/view/widgets/page_section.dart';

class TherapistProfilePage extends StatefulWidget {
  final Therapist therapist;
  final bool allowBooking;

  const TherapistProfilePage(this.therapist, [this.allowBooking = true]);

  @override
  _TherapistProfilePageState createState() => _TherapistProfilePageState();
}

class _TherapistProfilePageState extends State<TherapistProfilePage> {
  MeetingCharge selectedMeetingCharge;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EligibilityCheckBloc>(
      create: (context) => EligibilityCheckBloc(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<EligibilityCheckBloc, EligibilityCheckState>(
            listener: (context, state) {
              if (state is FollowupNotEligible) {
                widget.showErrorDialog(
                    context: context,
                    message:
                        "You are not eligible for a follow up appointment. Please book a new one.",
                    showIcon: true,
                    onPressed: () async {
                      Navigator.of(context).pop();
                    });
              }

              if (state is FollowupEligiblie) {
                navigateToTimeslotSelection(context);
              }
            },
            builder: (context, state) {
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
                              HeaderSection(
                                  widget.therapist.fullName,
                                  widget.therapist.therapistType.name,
                                  widget.therapist.medicalCouncil,
                                  widget.therapist.totalExperience.toString(),
                                  widget.therapist.file != null
                                      ? widget.therapist.file.name
                                          .withBaseUrlForImage()
                                      : ""),
                              SizedBox(
                                height: 24.0,
                              ),
                              ExpertiseSection(
                                  widget.therapist.therapistType.expertise,
                                  widget.therapist.therapistType.specialisation,
                                  getDisorderNames(widget.therapist.disorderTypes)),
                              SizedBox(
                                height: 16.0,
                              ),
                              QualificationSection(
                                  widget.therapist.qualification),
                              SizedBox(
                                height: 16.0,
                              ),
                              LanguageSection(widget.therapist.spokenLanguage),
                              Divider(
                                height: 32.0,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Visibility(
                                visible: widget.allowBooking == true,
                                child: MeetingChargesSection(
                                    widget.therapist.charges,
                                    widget.therapist.meetingDuration?.duration
                                        .toString(), (selectedMeeting) {
                                  setState(() =>
                                      selectedMeetingCharge = selectedMeeting);
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: state is EligibilityChecking,
                        child: LinearProgressIndicator(
                          minHeight: 2.0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Visibility(
                        visible: widget.allowBooking == true,
                        child: BookAppointmentButton(state
                                is EligibilityChecking
                            ? null
                            : () {
                                if (selectedMeetingCharge != null &&
                                    selectedMeetingCharge.meetingType
                                            .toLowerCase()
                                            .trim() ==
                                        "follow up") {
                                  BlocProvider.of<EligibilityCheckBloc>(context)
                                      .add(CheckFollowupEligibility(
                                          widget.therapist.id,
                                          selectedMeetingCharge.meetingTypeId));
                                } else if (selectedMeetingCharge != null)
                                  navigateToTimeslotSelection(context);
                                else
                                  widget.showErrorDialog(
                                      context: context,
                                      message:
                                          "Please select an appointment type",
                                      showIcon: true,
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      });
                              }),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<String> getDisorderNames(List<Disorder> disorderTypes) {
      return disorderTypes.map((disorder) {
        return disorder.name;
      }).toList();
    }

  void navigateToTimeslotSelection(BuildContext context) {
    Navigator.of(context).pushNamed(
      RouteName.APPOINTMENT_DATE_SELECTION_PAGE,
      arguments: AppointmentDateSelectionArguments(
          widget.therapist, selectedMeetingCharge),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final String therapistName;
  final String therapistType;
  final String medicalCouncil;
  final String profilePicUrl;
  final String experience;

  HeaderSection(this.therapistName, this.therapistType, this.medicalCouncil,
      this.experience, this.profilePicUrl);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatarOrInitials(
            radius: 32.0,
            imageUrl: profilePicUrl,
            stringForInitials: therapistName,
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  therapistName ?? "",
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  therapistType ?? "",
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.clip,
                ),
                Visibility(
                  visible: medicalCouncil != null,
                  child: Text(
                    medicalCouncil ?? "",
                    style: Theme.of(context).textTheme.caption,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
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
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.purple.shade50),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    experience,
                    style: Theme.of(context).textTheme.headline6.copyWith(
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
  final String therapistQualification;

  QualificationSection(this.therapistQualification);

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
        description: therapistQualification);
  }
}

class LanguageSection extends StatelessWidget {
  final String languages;
  LanguageSection(this.languages);

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
        description: languages);
  }
}

class ExpertiseSection extends StatelessWidget {
  final String therapistExpertise;
  final String therapistSpecialization;
  final List<String> disorderTypes;

  const ExpertiseSection(this.therapistExpertise, this.therapistSpecialization,
      this.disorderTypes);

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
            description: therapistExpertise,
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
            description: therapistSpecialization,
          ),
          SizedBox(height: 16.0),
          PageSection(
            textColor: Colors.teal,
            icon: Icon(
              Icons.emoji_objects_outlined,
              size: 20.0,
              color: Colors.teal,
            ),
            title: "Advisory for",
            description: disorderTypes.join(", "),
          ),
        ],
      ),
    );
  }
}

class MeetingChargesSection extends StatefulWidget {
  final List<MeetingCharge> meetingCharges;
  final String meetingDuration;
  final ValueChanged<MeetingCharge> onChargeSelected;

  MeetingChargesSection(
      this.meetingCharges, this.meetingDuration, this.onChargeSelected);

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
                "Appointment charges",
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
                          text: "${widget.meetingDuration} minutes",
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
            itemCount: widget.meetingCharges.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onChargeSelected(widget.meetingCharges[index]);
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
                        widget.meetingCharges[index].meetingType,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.black87),
                      ),
                      Spacer(),
                      Text(
                        Strings.rupeeSymbol +
                            "${widget.meetingCharges[index].amount}",
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
  final VoidCallback onPressed;
  BookAppointmentButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      disabledColor: Colors.grey.shade400,
      height: 56.0,
      minWidth: double.maxFinite,
      child: Text(
        "Book an appointment".toUpperCase(),
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              wordSpacing: 1.0,
              letterSpacing: 0.75,
              color: Colors.white,
            ),
      ),
    );
  }
}
