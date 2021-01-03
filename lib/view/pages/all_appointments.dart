import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/appointment/appointment_bloc.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/appointment/appointment_detail_arguments.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/models/therapist/therapist_type.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/appointment_card.dart';
import 'package:greycells/view/widgets/appointment_status_selector.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';

class AllAppointments extends StatefulWidget {
  final UserType userType;
  final TherapistType therapistType;

  AllAppointments(this.userType, {this.therapistType});

  @override
  _AllAppointmentsState createState() => _AllAppointmentsState();
}

class _AllAppointmentsState extends State<AllAppointments> {
  AppointmentStatus _status;
  @override
  void initState() {
    super.initState();
    _status = AppointmentStatus.upcoming;
    _loadAppointments(_status);
  }

  _loadAppointments(AppointmentStatus status) {
    BlocProvider.of<AppointmentBloc>(context)
        .add(LoadAppointments(1, status: status));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.0,
            ),
            AppointmentStatusSelector((selectedStatus) {
              _status = selectedStatus;
              _loadAppointments(_status);
            }, AppointmentStatus.upcoming),
            Divider(),
            if (state is AppointmentsLoading)
              Expanded(child: CenteredCircularLoadingIndicator()),
            if (state is AppointmentsLoaded)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                child: CountSection(
                  count: state.allAppointments.length,
                ),
              ),
            if (state is AppointmentsLoaded)
              Expanded(
                child: AppointmentList(
                  allAppointments: state.allAppointments,
                  userType: widget.userType,
                ),
              ),
            if (state is AppointmentsEmpty) Expanded(child: EmptyState()),
            if (state is AppointmentsLoadError)
              ErrorWithRetry(
                onRetryPressed: () {
                  _loadAppointments(_status);
                },
              ),
          ],
        );
      },
    );
  }
}

class CountSection extends StatelessWidget {
  final int count;

  const CountSection({Key key, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.teal.shade50,
      ),
      child: RichText(
        text: TextSpan(
          text: count.toString(),
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: Colors.teal.shade700, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: count > 1 ?"  appointments".toUpperCase(): "  appointment".toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .overline
                  .copyWith(color: Colors.teal.shade700,),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentList extends StatelessWidget {
  final List<Appointment> allAppointments;
  final UserType userType;

  const AppointmentList(
      {Key key, @required this.allAppointments, @required this.userType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: AppointmentCard(allAppointments[index], userType, () {
            Navigator.of(context).pushNamed(RouteName.APPOINTMENT_DETAIL_PAGE,
                arguments: AppointmentDetailArguments(
                    allAppointments[index], userType));
          }),
        );
      },
      itemCount: allAppointments.length,
    );
  }
}
