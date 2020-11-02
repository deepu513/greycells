import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/appointment/appointment_bloc.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/view/widgets/appointment_card.dart';
import 'package:greycells/view/widgets/appointment_status_selector.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';

class AllAppointments extends StatefulWidget {
  final UserType userType;

  AllAppointments(this.userType);

  @override
  _AllAppointmentsState createState() => _AllAppointmentsState();
}

class _AllAppointmentsState extends State<AllAppointments> {

  @override
  void initState() { 
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        if (state is AppointmentsLoading)
          return CenteredCircularLoadingIndicator();

        if (state is AppointmentsEmpty) return EmptyState();

        if (state is AppointmentsLoadError)
          return ErrorWithRetry(
            onRetryPressed: () {},
          );

        if (state is AppointmentsLoaded)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              AppointmentStatusSelector((selectedStatus) {
                
              }),
              Divider(),
              Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                      child: AppointmentCard(
                          state.allAppointments[index], widget.userType),
                    );
                  },
                ),
              ),
            ],
          );

        return Container();
      },
    );
  }
}
