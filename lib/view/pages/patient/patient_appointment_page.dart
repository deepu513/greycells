import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/appointment/appointment_bloc.dart';
import 'package:greycells/bloc/therapist/bloc/therapist_type_bloc.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/therapist/therapist_type.dart';
import 'package:greycells/view/pages/all_appointments.dart';

class PatientAppointmentPage extends StatelessWidget {
  const PatientAppointmentPage();

  @override
  Widget build(BuildContext context) {
    return _ActualWidget();
  }
}

class _ActualWidget extends StatefulWidget {
  @override
  _ActualWidgetPageState createState() => _ActualWidgetPageState();
}

class _ActualWidgetPageState extends State<_ActualWidget> {
  TherapistTypeBloc _therapistTypeBloc;
  TherapistType selectedTherapistType;

  @override
  void initState() {
    super.initState();
    _therapistTypeBloc = TherapistTypeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentBloc>(
      create: (context) => AppointmentBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              elevation: 4.0,
              title: Text(
                'Appointments',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.black87),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.filter_list_rounded),
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                )
              ],
            ),
            body: SafeArea(
              child: AllAppointments(
                UserType.patient,
                therapistType: selectedTherapistType,
              ),
            ),
          );
        },
      ),
    );
  }

  _showBottomSheet(context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      context: context,
      isDismissible: true,
      builder: (newContext) {
        return BlocProvider<TherapistTypeBloc>.value(
          value: _therapistTypeBloc,
          child: TherapistTypesFilter(
              onTherapistTypeSelected: (therapistType) {
                selectedTherapistType = therapistType;
                if (therapistType.id == -1) {
                  BlocProvider.of<AppointmentBloc>(context)
                      .add(LoadAppointments(1));
                } else
                  BlocProvider.of<AppointmentBloc>(context)
                      .add(LoadAppointments(1, therapistType: therapistType));
              },
              selectedTherapistType: selectedTherapistType),
        );
      },
    );
  }

  @override
  void dispose() {
    _therapistTypeBloc.close();
    super.dispose();
  }
}

class TherapistTypesFilter extends StatefulWidget {
  final ValueChanged<TherapistType> onTherapistTypeSelected;
  final TherapistType selectedTherapistType;

  const TherapistTypesFilter(
      {Key key,
      @required this.onTherapistTypeSelected,
      this.selectedTherapistType})
      : super(key: key);

  @override
  _TherapistTypesFilterState createState() => _TherapistTypesFilterState();
}

class _TherapistTypesFilterState extends State<TherapistTypesFilter> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TherapistTypeBloc>(context).add(LoadTherapistTypes());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapistTypeBloc, TherapistTypeState>(
      builder: (context, state) {
        if (state is TherapistTypesLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Select a therapist type",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Expanded(
                child: TherapistTypesList(
                  therapistTypes: state.therapistTypes,
                  onTherapistTypeSelected: widget.onTherapistTypeSelected,
                  selectedType: widget.selectedTherapistType,
                ),
              )
            ],
          );
        } else if (state is TherapistTypesError) {
          return Center(child: Text("There was some problem loading filters"));
        } else if (state is TherapistTypesEmpty) {
          return Center(child: Text("There was some problem loading filters"));
        } else if (state is TherapistTypesLoading)
          return Center(child: CircularProgressIndicator());
        return Container();
      },
    );
  }
}

class TherapistTypesList extends StatefulWidget {
  final List<TherapistType> therapistTypes;
  final ValueChanged<TherapistType> onTherapistTypeSelected;
  final TherapistType selectedType;

  const TherapistTypesList(
      {Key key,
      @required this.therapistTypes,
      @required this.onTherapistTypeSelected,
      this.selectedType})
      : super(key: key);

  @override
  _TherapistTypesListState createState() => _TherapistTypesListState();
}

class _TherapistTypesListState extends State<TherapistTypesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.therapistTypes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.therapistTypes[index].name),
          leading: widget.selectedType != null &&
                  widget.selectedType.id == widget.therapistTypes[index].id
              ? Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green,
                )
              : Icon(Icons.panorama_fish_eye_rounded),
          onTap: () {
            widget.onTherapistTypeSelected.call(widget.therapistTypes[index]);
            Navigator.pop(context);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
