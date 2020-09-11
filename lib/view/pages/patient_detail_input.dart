import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/page_transition/bloc.dart';
import 'package:greycells/bloc/page_transition/page_transition_bloc.dart';
import 'package:greycells/bloc/patient_details/patient_details_bloc.dart';
import 'package:greycells/bloc/picker/file_picker_bloc.dart';
import 'package:greycells/bloc/picker/image_picker_bloc.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/interface/validatable.dart';
import 'package:greycells/view/pages/address_details_input_page.dart';
import 'package:greycells/view/pages/birth_details_input_page.dart';
import 'package:greycells/view/pages/guardian_details_input_page.dart';
import 'package:greycells/view/pages/health_details_input_page.dart';
import 'package:greycells/view/pages/medical_records_input_page.dart';
import 'package:greycells/view/pages/patient_upload_page.dart';
import 'package:greycells/view/pages/profile_pic_input_page.dart';
import 'package:greycells/view/widgets/navigation_button_row.dart';

class PatientDetailInput extends StatefulWidget {
  @override
  _PatientDetailInputState createState() => _PatientDetailInputState();
}

class _PatientDetailInputState extends State<PatientDetailInput>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _progressAnimation;
  final animationDuration = 500;

  final initialPageNumber = 1;
  final numberOfPages = 7;

  List<Widget> _pages;

  var _patientDetailUploading = false;

  @override
  void initState() {
    super.initState();

    _pages = List.unmodifiable(<Widget>[
      const ProfilePicInputPage(),
      const BirthDetailsInputPage(),
      const HealthDetailsInputPage(),
      const GuardianDetailsInputPage(),
      const AddressDetailInputPage(),
      const MedicalRecordsInputPage(),
      PatientUploadPage(
        onUploadStart: _onUploadStart,
        onError: _onUploadError,
      ),
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
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        _patientDetailUploading = true;
      });
    });
  }

  void _onUploadError() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        _patientDetailUploading = false;
      });
    });
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
        BlocProvider<PatientDetailsBloc>(
          create: (context) => PatientDetailsBloc(),
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
                        onBackPressed: _patientDetailUploading
                            ? null
                            : () =>
                                _handleBackPressed(context, transitionState),
                        onNextPressed: _patientDetailUploading
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
    if (transitionState.currentPageNumber == 5 &&
        BlocProvider.of<PatientDetailsBloc>(context).patient.isMinor == false) {
      BlocProvider.of<PageTransitionBloc>(context).add(SkipPages(-2));
    } else
      BlocProvider.of<PageTransitionBloc>(context)
          .add(TransitionToPreviousPage());
  }

  void _transitionToNextPage(
      BuildContext context, PageTransitionState transitionState) {
    if (transitionState.currentPageNumber == 3 &&
        BlocProvider.of<PatientDetailsBloc>(context).patient.isMinor == false) {
      BlocProvider.of<PageTransitionBloc>(context).add(SkipPages(2));
    } else
      BlocProvider.of<PageTransitionBloc>(context).add(TransitionToNextPage());
  }
}
