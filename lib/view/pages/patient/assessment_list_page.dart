import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/assessment/assessment_bloc.dart';
import 'package:greycells/bloc/assessment/assessment_score_bloc.dart';
import 'package:greycells/models/home/patient_home.dart';
import 'package:greycells/models/payment/payment.dart';
import 'package:greycells/models/payment/payment_item.dart';
import 'package:greycells/models/payment/payment_type.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';
import 'package:greycells/extensions.dart';
import 'package:provider/provider.dart';

class AssessmentListPage extends StatefulWidget {
  @override
  _AssessmentListPageState createState() => _AssessmentListPageState();
}

class _AssessmentListPageState extends State<AssessmentListPage> {
  int patientId;

  @override
  void initState() {
    super.initState();
    patientId = Provider.of<PatientHome>(context, listen: false).patient.id;
    _loadAllAssessments();
  }

  void _loadAllAssessments() {
    BlocProvider.of<AssessmentScoreBloc>(context)
        .add(LoadAssessmentScores(patientId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          "All Assessments",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
      ),
      floatingActionButton: Visibility(
        visible: Provider.of<PatientHome>(context, listen: false)
                .patient
                .isEligibleForTest ==
            false,
        child: FloatingActionButton.extended(
          onPressed: () {
            final payment = Payment()
              ..type = PaymentType.ASSESSMENT
              ..title = "Book New Test"
              ..itemTitle = "Assessment Test"
              ..itemSubtitle = "Behaviour and Personality Assessment"
              ..promoCodeApplied = false
              ..discountAmount = 0
              ..originalAmount = 300 // TODO: This needs to come from backend.
              ..items = [
                PaymentItem()
                  ..itemName = "1 Test"
                  ..itemPrice = 300
              ]
              ..totalAmount = 300;
            // ..extras = {
            //   // * Payment id should be added after payment
            //   Strings.createAppointmentRequest: CreateAppointmentRequest()
            //     ..therapistId = widget.therapist.id
            //     ..comments = ""
            //     ..duration = widget.therapist.meetingDuration.duration
            //     ..patientId = Provider.of<PatientHome>(context, listen: false)
            //         .patient
            //         .id
            //     ..timeslotId = mSelectedTimeslot.id
            //     ..meetingTypeId = widget.selectedMeeting.meetingTypeId
            //     ..chargeId = widget.selectedMeeting.chargeId
            //     ..appointmentDate = mSelectedDay.formatToddMMyyyy()
            //     ..appointmentDateTime = _getAppointmentDateTime(
            //         mSelectedDay, mSelectedTimeslot.startTime)
            // };
            Navigator.of(context)
                .pushNamed(RouteName.PAYMENT_PAGE, arguments: payment);
          },
          icon: Icon(Icons.add),
          label: Text('TAKE NEW'),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AssessmentScoreBloc, AssessmentScoreState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AssessmentScoreLoading)
              return CenteredCircularLoadingIndicator();
            if (state is AssessmentScoreLoaded)
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          RouteName.PATIENT_SCORE_PAGE,
                          arguments: state.assessmentScores[index]);
                    },
                    title: Text(
                      "Assessment #${index + 1}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        "Completed on ${state.assessmentScores[index].assessment.createdDate.asDate().readableDate()}"),
                    trailing: Icon(Icons.chevron_right_rounded),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: state.assessmentScores.length,
              );
            if (state is AssessmentScoreEmpty) return EmptyState();
            if (state is AssessmentError)
              return ErrorWithRetry(
                onRetryPressed: () {
                  _loadAllAssessments();
                },
              );
            return Container();
          },
        ),
      ),
    );
  }
}
