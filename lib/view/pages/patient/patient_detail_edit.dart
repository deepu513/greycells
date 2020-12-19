import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/page_transition/bloc.dart';
import 'package:greycells/bloc/page_transition/page_transition_bloc.dart';
import 'package:greycells/bloc/patient_details/patient_details_edit_bloc.dart';
import 'package:greycells/bloc/picker/file_picker_bloc.dart';
import 'package:greycells/bloc/picker/image_picker_bloc.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/interface/validatable.dart';
import 'package:greycells/models/home/patient_home.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/pages/patient/address_details_edit_page.dart';
import 'package:greycells/view/pages/patient/guardian_details_edit_page.dart';
import 'package:greycells/view/pages/patient/health_details_edit_page.dart';
import 'package:greycells/view/pages/patient/medical_records_input_page.dart';
import 'package:greycells/view/pages/patient/patient_upload_page.dart';
import 'package:greycells/view/pages/patient/personal_details_edit_page.dart';
import 'package:greycells/view/widgets/navigation_button_row.dart';
import 'package:provider/provider.dart';

class PatientDetailEdit extends StatefulWidget {
  @override
  _PatientDetailEditState createState() => _PatientDetailEditState();
}

class _PatientDetailEditState extends State<PatientDetailEdit>
    with SingleTickerProviderStateMixin {
  Patient patient;

  AnimationController _controller;
  Animation<double> _progressAnimation;
  final animationDuration = 500;

  final initialPageNumber = 1;
  final numberOfPages = 5;

  List<Widget> _pages;

  var _patientDetailUploading = false;
  var _patientDetailUploadComplete = false;

  @override
  void initState() {
    super.initState();

    patient = Provider.of<PatientHome>(context, listen: false).patient;

    _pages = List.unmodifiable(<Widget>[
      const PersonalDetailsEditPage(),
      const HealthDetailsEditPage(),
      const GuardianDetailsEditPage(),
      const AddressDetailEditPage(),
      // const MedicalRecordsInputPage(),
      // PatientUploadPage(
      //   onUploadStart: _onUploadStart,
      //   onUploadComplete: _onUploadComplete,
      //   onError: _onUploadError,
      // ),
    ]);

    _controller = AnimationController(vsync: this);

    _progressAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _controller.animateTo(initialPageNumber / (numberOfPages - 1),
        duration: Duration(milliseconds: animationDuration));
  }

  void _onUploadStart() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _patientDetailUploading = true;
        _patientDetailUploadComplete = false;
      });
    });
  }

  void _onUploadError() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _patientDetailUploading = false;
        _patientDetailUploadComplete = false;
      });
    });
  }

  void _onUploadComplete() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _patientDetailUploading = false;
        _patientDetailUploadComplete = true;

        Future.delayed(Duration(seconds: 1), () {
          _navigateToTestPage();
        });
      });
    });
  }

  void _navigateToTestPage() {
    Navigator.of(context)
        .pushNamed(RouteName.ASSESSMENT_TEST_INTRO, arguments: false);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImagePickerBloc>(
          create: (context) => ImagePickerBloc(),
        ),
        BlocProvider<FilePickerBloc>(
          create: (context) => FilePickerBloc(),
        ),
        BlocProvider<ValidationBloc>(
          create: (context) => ValidationBloc(),
        ),
        BlocProvider<PatientDetailsEditBloc>(
          create: (context) => PatientDetailsEditBloc(patient),
        ),
        BlocProvider<PageTransitionBloc>(
          create: (context) => PageTransitionBloc(
              numberOfPages: numberOfPages,
              initialPageNumber: initialPageNumber),
        )
      ],
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.only(top: 56.0),
          child: BlocListener<PageTransitionBloc, PageTransitionState>(
            listener: (context, current) {
              _controller.animateBack(
                  (current.currentPageNumber) / (numberOfPages - 1),
                  duration: Duration(milliseconds: animationDuration));
            },
            child: BlocBuilder<PageTransitionBloc, PageTransitionState>(
              buildWhen: (previous, current) {
                return current is PageTransitionInitial ||
                    current is PageTransitionToNextPage ||
                    current is PageTransitionToPreviousPage;
              },
              builder: (context, transitionState) {
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: PageTransitionSwitcher(
                        duration: const Duration(milliseconds: 300),
                        reverse: transitionState.currentPageNumber == 1
                            ? true
                            : false,
                        transitionBuilder: (Widget child,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return SharedAxisTransition(
                            child: child,
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                          );
                        },
                        child: _pages[transitionState.currentPageNumber - 1],
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                      child: AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: _patientDetailUploading
                                ? null
                                : _progressAnimation.value,
                            backgroundColor: Colors.blue.shade100,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: NavigationButtonRow(
                        onBackPressed: _patientDetailUploading ||
                                _patientDetailUploadComplete
                            ? null
                            : () =>
                                _handleBackPressed(context, transitionState),
                        onNextPressed: _patientDetailUploading ||
                                _patientDetailUploadComplete
                            ? null
                            : () =>
                                _handleNextPressed(context, transitionState),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _handleNextPressed(
      BuildContext context, PageTransitionState transitionState) async {
    if (_shouldValidateCurrentPage(transitionState)) {
      var result = await _validateCurrentPage(context, transitionState);
      //var result = true;
      if (result == true) _transitionToNextPage(context, transitionState);
    } else {
      _transitionToNextPage(context, transitionState);
    }
  }

  Future<bool> _validateCurrentPage(
      BuildContext context, PageTransitionState transitionState) async {
    try {
      Validatable validatable =
          _pages[transitionState.currentPageNumber - 1] as Validatable;
      return await validatable.validate(
          context, BlocProvider.of<ValidationBloc>(context));
    } catch (e) {
      return false;
    }
  }

  bool _shouldValidateCurrentPage(PageTransitionState transitionState) =>
      _pages[transitionState.currentPageNumber - 1] is Validatable;

  void _handleBackPressed(
      BuildContext context, PageTransitionState transitionState) {
    BlocProvider.of<PageTransitionBloc>(context)
        .add(TransitionToPreviousPage());
  }

  void _transitionToNextPage(
      BuildContext context, PageTransitionState transitionState) {
    BlocProvider.of<PageTransitionBloc>(context).add(TransitionToNextPage());
  }
}
