import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/therapist/bloc/therapist_bloc.dart';
import 'package:greycells/bloc/therapist/bloc/therapist_type_bloc.dart';
import 'package:greycells/models/therapist/therapist_type.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';
import 'package:greycells/view/widgets/therapist_list_tile.dart';

class TherapistListPage extends StatefulWidget {
  @override
  _TherapistListPageState createState() => _TherapistListPageState();
}

class _TherapistListPageState extends State<TherapistListPage> {
  TherapistTypeBloc _therapistTypeBloc;
  TherapistType selectedTherapistType;

  @override
  void initState() {
    super.initState();
    _therapistTypeBloc = TherapistTypeBloc();
    _loadTherapists();
  }

  void _loadTherapists() {
    BlocProvider.of<TherapistBloc>(context).add(LoadTherapists());
  }

  void _loadTherapistWithType(TherapistType therapistType) {
    BlocProvider.of<TherapistBloc>(context)
        .add(LoadTherapistsWithType(therapistType));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          'All Therapists',
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
        child: BlocConsumer<TherapistBloc, TherapistState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TherapistsLoading) {
              return CenteredCircularLoadingIndicator();
            }

            if (state is TherapistsLoaded) {
              return Container(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    itemBuilder: (context, index) {
                      return TherapistListTile(
                          therapist: state.therapists[index]);
                    },
                    itemCount: state.therapists.length),
              );
            }

            if (state is TherapistsEmpty) {
              return EmptyState();
            }

            if (state is TherapistsLoadError) {
              return ErrorWithRetry(
                onRetryPressed: () {
                  _loadTherapists();
                },
              );
            }

            return Container();
          },
        ),
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
                if (therapistType.id == -1)
                  _loadTherapists();
                else
                  _loadTherapistWithType(therapistType);
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
