//import 'package:animations/animations.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/painting.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:mental_health/bloc/authentication/bloc.dart';
//import 'package:mental_health/bloc/city/city_bloc.dart';
//import 'package:mental_health/bloc/city/city_event.dart';
//import 'package:mental_health/bloc/city/city_state.dart';
//import 'package:mental_health/bloc/page_transition/bloc.dart';
//import 'package:mental_health/bloc/registration/registration_bloc.dart';
//import 'package:mental_health/bloc/registration/registration_event.dart';
//import 'package:mental_health/bloc/registration/registration_state.dart';
//import 'package:mental_health/bloc/selection/selection_bloc.dart';
//import 'package:mental_health/bloc/selection/selection_event.dart';
//import 'package:mental_health/bloc/selection/selection_state.dart';
//import 'package:mental_health/bloc/validation/validation_bloc.dart';
//import 'package:mental_health/bloc/validation/validation_state.dart';
//import 'package:mental_health/constants/route_name.dart';
//import 'package:mental_health/models/city/city.dart';
//import 'package:mental_health/models/user/user.dart';
//import 'package:mental_health/view/widgets/linear_loading_indicator.dart';
//import 'package:mental_health/view/widgets/navigation_button_row.dart';
//import 'package:mental_health/view/widgets/no_glow_scroll_behaviour.dart';
//import 'package:provider/provider.dart';
//
//class LoginPage extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return LoginPageState();
//  }
//}
//
//class LoginPageState extends State<LoginPage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SafeArea(
//        minimum: EdgeInsets.fromLTRB(24.0, 56.0, 24.0, 16.0),
//        child: MultiBlocProvider(
//          providers: [
//            BlocProvider(
//              create: (context) => RegistrationBloc(ValidationBloc()),
//            ),
//            BlocProvider(
//              create: (context) =>
//                  PageTransitionBloc(numberOfPages: 1, initialPageNumber: 0),
//            )
//          ],
//          child: MultiBlocListener(
//            listeners: [
//              BlocListener<AuthenticationBloc, AuthenticationState>(
//                listener: (context, authenticationState) {
//                  if (authenticationState is AuthenticationFailure) {
//                    _showError(context);
//                  }
//
//                  if (authenticationState is AuthenticationAuthenticated) {
//                    var updatedUser = authenticationState.user;
//                    _updateUser(updatedUser);
//
//                    Navigator.pushNamedAndRemoveUntil(context, RouteName.HOME,
//                        (Route<dynamic> route) => false);
//                  }
//
//                  if (authenticationState is AuthenticationUserNotFound) {
//                    BlocProvider.of<PageTransitionBloc>(context)
//                        .add(TransitionToNextPage());
//                  }
//                },
//              ),
//              BlocListener<RegistrationBloc, RegistrationState>(
//                listener: (context, registrationState) {
//                  if (registrationState is RegistrationUnsuccessful) {
//                    _showError(context);
//                  }
//
//                  if (registrationState is RegistrationSuccessful) {
//                    var updatedUser = registrationState.user;
//                    _updateUser(updatedUser);
//                    Navigator.pushNamedAndRemoveUntil(context, RouteName.HOME,
//                        (Route<dynamic> route) => false);
//                  }
//                },
//              ),
//              BlocListener<PageTransitionBloc, PageTransitionState>(
//                listener: (context, pageTransitionState) {
//                  if (pageTransitionState is PageTransitionReachedLowerLimit) {
//                    Navigator.pop(context);
//                  }
//                },
//              )
//            ],
//            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//              builder: (context, authenticationState) {
//                return BlocBuilder<RegistrationBloc, RegistrationState>(
//                  builder: (context, registrationState) {
//                    return BlocBuilder<PageTransitionBloc, PageTransitionState>(
//                      condition: (previous, current) {
//                        return current is PageTransitionInitial ||
//                            current is PageTransitionToNextPage ||
//                            current is PageTransitionToPreviousPage;
//                      },
//                      builder: (context, transitionState) {
//                        return Column(
//                          children: <Widget>[
//                            Expanded(
//                              child: PageTransitionSwitcher(
//                                duration: const Duration(milliseconds: 300),
//                                reverse: transitionState.currentPageNumber == 0
//                                    ? true
//                                    : false,
//                                transitionBuilder: (Widget child,
//                                    Animation<double> animation,
//                                    Animation<double> secondaryAnimation) {
//                                  return SharedAxisTransition(
//                                    child: child,
//                                    animation: animation,
//                                    secondaryAnimation: secondaryAnimation,
//                                    transitionType:
//                                        SharedAxisTransitionType.horizontal,
//                                  );
//                                },
//                                child: _getPage(context, transitionState),
//                              ),
//                            ),
//                            NavigationButtonRow(
//                              onBackPressed: authenticationState
//                                          is AuthenticationLoading ||
//                                      registrationState
//                                          is RegistrationInProgress
//                                  ? null
//                                  : () => _handleBackPressed(context),
//                              onNextPressed: authenticationState
//                                          is AuthenticationLoading ||
//                                      registrationState
//                                          is RegistrationInProgress
//                                  ? null
//                                  : () => _handleNextPressed(
//                                      context, transitionState),
//                            ),
//                          ],
//                        );
//                      },
//                    );
//                  },
//                );
//              },
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  _updateUser(User updatedUser) {
//    Provider.of<User>(context)
//      ..id = updatedUser.id
//      ..name = updatedUser.name
//      ..contactNumber = updatedUser.contactNumber
//      ..city = updatedUser.city
//      ..userType = updatedUser.userType
//      ..profilePictureUrl = updatedUser.profilePictureUrl;
//  }
//
//  Widget _getPage(BuildContext context, PageTransitionState transitionState) {
//    if (transitionState.currentPageNumber == 0)
//      return ContactInputPage();
//    else if (transitionState.currentPageNumber == 1)
//      return UserRegistrationPage();
//
//    return null; // Should never happen
//  }
//
//  _handleBackPressed(BuildContext context) {
//    BlocProvider.of<PageTransitionBloc>(context)
//        .add(TransitionToPreviousPage());
//  }
//
//  _handleNextPressed(
//      BuildContext context, PageTransitionState transitionState) {
//    if (transitionState.currentPageNumber == 0) {
//      _requestUserLogin(context, Provider.of<User>(context, listen: false));
//    } else if (transitionState.currentPageNumber == 1) {
//      _requestCreateNewUser(context, Provider.of<User>(context, listen: false));
//    }
//  }
//
//  _requestUserLogin(BuildContext context, User user) {
//    BlocProvider.of<AuthenticationBloc>(context)
//        .add(LoginInitiated(contactNumber: user.contactNumber));
//  }
//
//  _requestCreateNewUser(BuildContext context, User user) {
//    BlocProvider.of<RegistrationBloc>(context)
//        .add(RegistrationCreateUser(user: user));
//  }
//
//  _showError(BuildContext context) {
//    // TODO: Show a dialog here instead of snackbar
//    Scaffold.of(context).showSnackBar(
//      SnackBar(
//        content: Text("Error! Please try again"),
//        // TODO: Change error message
//        action: SnackBarAction(
//          label: 'Retry',
//          onPressed: () => _requestUserLogin(
//              context, Provider.of<User>(context, listen: false)),
//        ),
//      ),
//    );
//  }
//}
//
//class ContactInputPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Text(
//          AppLocalizations.of(context).translate("message_need_contact"),
//          style: TextStyle(
//              fontSize: 36.0,
//              fontWeight: FontWeight.w300,
//              color: Theme.of(context).accentColor),
//        ),
//        SizedBox(
//          height: 24.0,
//        ),
//        ContactInputTextField(),
//        SizedBox(
//          height: 8.0,
//        ),
//        BlocBuilder<AuthenticationBloc, AuthenticationState>(
//          builder: (context, authenticationState) {
//            return LinearLoadingIndicator(
//                visibility: authenticationState is AuthenticationLoading);
//          },
//        ),
//        SizedBox(
//          height: 16.0,
//        ),
//        Expanded(
//          child: ScrollConfiguration(
//            behavior: NoGlowScrollBehaviour(),
//            child: FaqListView(),
//          ),
//        ),
//      ],
//    );
//  }
//}
//
//class ContactInputTextField extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
//        builder: (context, authenticationState) {
//      return BlocBuilder<ValidationBloc, ValidationState>(
//        bloc: BlocProvider.of<AuthenticationBloc>(context).validationBloc,
//        builder: (context, validationState) {
//          return TextField(
//            maxLines: 1,
//            maxLength: 10,
//            controller: TextEditingController(
//                text: Provider.of<User>(context, listen: false).contactNumber ??
//                    ""),
//            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
//            decoration: InputDecoration(
//              border: InputBorder.none,
//              hintText:
//                  AppLocalizations.of(context).translate("action_tap_to_enter"),
//              hintStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
//              icon: Text(
//                "+91",
//                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
//              ),
//              errorText: _isStateFieldInvalid(validationState)
//                  ? "that doesn't look like a valid contact number"
//                  : null,
//            ),
//            autofocus: false,
//            keyboardType: TextInputType.phone,
//            inputFormatters: <TextInputFormatter>[
//              WhitelistingTextInputFormatter.digitsOnly
//            ],
//            autocorrect: false,
//            onChanged: (value) =>
//                Provider.of<User>(context, listen: false).contactNumber = value,
//            enabled: authenticationState is! AuthenticationLoading,
//          );
//        },
//      );
//    });
//  }
//
//  bool _isStateFieldInvalid(ValidationState validationState) {
//    return validationState is ValidationFailed &&
//        validationState.field == ValidationField.CONTACT_NUMBER;
//  }
//}
//
//class UserRegistrationPage extends StatefulWidget {
//  @override
//  _UserRegistrationPageState createState() => _UserRegistrationPageState();
//}
//
//class _UserRegistrationPageState extends State<UserRegistrationPage> {
//  @override
//  Widget build(BuildContext context) {
//    return ScrollConfiguration(
//        behavior: NoGlowScrollBehaviour(),
//        child: ListView(
//          children: <Widget>[
//            ..._headerSectionWidgets(context),
//            SizedBox(
//              height: 8.0,
//            ),
//            BlocBuilder<RegistrationBloc, RegistrationState>(
//              builder: (context, registrationState) {
//                return LinearLoadingIndicator(
//                    visibility: registrationState is RegistrationInProgress);
//              },
//            ),
//            SizedBox(
//              height: 24.0,
//            ),
//            InkWell(
//                child: AvatarWidget(),
//                onTap: () {}, // TODO: Handle this
//                splashColor: Colors.green[100]),
//            SizedBox(
//              height: 24.0,
//            ),
//
//            /// Compulsory Field
//            NameInputWidget(),
//            SizedBox(
//              height: 12.0,
//            ),
//
//            /// Compulsory Field
//            PreFilledContactInputWidget(),
//            SizedBox(
//              height: 8.0,
//            ),
//
//            /// Compulsory Field
//            BlocProvider<SelectionBloc<City>>(
//                create: (context) => SelectionBloc<City>(),
//                child: CityChooserWidget()),
//            SizedBox(
//              height: 12.0,
//            ),
//          ],
//        ));
//  }
//
//  List<Widget> _headerSectionWidgets(BuildContext context) {
//    return [
//      Text(
//        AppLocalizations.of(context).translate("message_new_on_app"),
//        style: TextStyle(
//            fontSize: 36.0,
//            fontWeight: FontWeight.w300,
//            color: Theme.of(context).accentColor),
//      ),
//      SizedBox(
//        height: 12.0,
//      ),
//      Text(
//        AppLocalizations.of(context).translate("message_build_profile"),
//        style: TextStyle(
//            fontSize: 28.0,
//            fontWeight: FontWeight.w300,
//            color: Theme.of(context).accentColor),
//      )
//    ];
//  }
//}
//
//class AvatarWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(vertical: 8.0),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          CircleAvatar(
//            backgroundColor: Theme.of(context).accentColor,
//            child: Icon(
//              Icons.add,
//              size: 32.0,
//              color: Colors.green[50],
//            ),
//            radius: 28,
//          ),
//          SizedBox(
//            height: 16.0,
//          ),
//          Text(
//            AppLocalizations.of(context).translate("message_select_dp"),
//            style: TextStyle(fontSize: 16.0),
//            textAlign: TextAlign.center,
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//class NameInputWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return BlocBuilder<RegistrationBloc, RegistrationState>(
//        builder: (context, registrationState) {
//      return BlocBuilder<ValidationBloc, ValidationState>(
//        bloc: BlocProvider.of<RegistrationBloc>(context).validationBloc,
//        builder: (context, validationState) {
//          return TextField(
//            maxLines: 1,
//            controller: TextEditingController(
//                text: Provider.of<User>(context, listen: false).name ?? ""),
//            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
//            decoration: InputDecoration(
//              border: InputBorder.none,
//              helperText:
//                  AppLocalizations.of(context).translate("action_tap_to_enter"),
//              helperStyle: TextStyle(fontSize: 14.0),
//              labelText: AppLocalizations.of(context)
//                  .translate("message_tell_full_name"),
//              contentPadding: EdgeInsets.only(bottom: 4.0),
//              labelStyle: TextStyle(color: Theme.of(context).accentColor),
//              errorText: _isStateFieldInvalid(validationState)
//                  ? "ummm, you forgot to enter your name..."
//                  : null,
//            ),
//            autofocus: false,
//            onChanged: (value) =>
//                Provider.of<User>(context, listen: false).name = value,
//            keyboardType: TextInputType.text,
//            textCapitalization: TextCapitalization.words,
//            enabled: registrationState is! RegistrationInProgress,
//          );
//        },
//      );
//    });
//  }
//
//  bool _isStateFieldInvalid(ValidationState validationState) {
//    return validationState is ValidationFailed &&
//        validationState.field == ValidationField.NAME;
//  }
//}
//
//class PreFilledContactInputWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return BlocBuilder<RegistrationBloc, RegistrationState>(
//      builder: (context, registrationState) {
//        return BlocBuilder<ValidationBloc, ValidationState>(
//          bloc: BlocProvider.of<RegistrationBloc>(context).validationBloc,
//          builder: (context, validationState) {
//            return TextField(
//              controller: TextEditingController(
//                  text:
//                      Provider.of<User>(context, listen: false).contactNumber ??
//                          ""),
//              maxLines: 1,
//              maxLength: 10,
//              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
//              decoration: InputDecoration(
//                border: InputBorder.none,
//                labelText: AppLocalizations.of(context)
//                    .translate("message_verify_contact"),
//                prefixText: "+91 ",
//                labelStyle: TextStyle(color: Theme.of(context).accentColor),
//                errorText: _isStateFieldInvalid(validationState)
//                    ? "that doesn't look like a valid contact number"
//                    : null,
//              ),
//              autofocus: false,
//              keyboardType: TextInputType.phone,
//              onChanged: (value) => Provider.of<User>(context, listen: false)
//                  .contactNumber = value,
//              inputFormatters: <TextInputFormatter>[
//                WhitelistingTextInputFormatter.digitsOnly
//              ],
//              enabled: registrationState is! RegistrationInProgress,
//            );
//          },
//        );
//      },
//    );
//  }
//
//  bool _isStateFieldInvalid(ValidationState validationState) {
//    return validationState is ValidationFailed &&
//        validationState.field == ValidationField.CONTACT_NUMBER;
//  }
//}
//
//class CityChooserWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return BlocBuilder<SelectionBloc<City>, SelectionState<City>>(
//      builder: (context, selectionState) {
//        return BlocBuilder<RegistrationBloc, RegistrationState>(
//          builder: (context, registrationState) {
//            return BlocBuilder<ValidationBloc, ValidationState>(
//              bloc: BlocProvider.of<RegistrationBloc>(context).validationBloc,
//              builder: (context, validationState) {
//                return ListTile(
//                  contentPadding: EdgeInsets.all(0.0),
//                  onTap: registrationState is RegistrationInProgress
//                      ? null
//                      : () => _setupModalBottomSheet(context),
//                  subtitle: _getStyledSubtitle(
//                      context, selectionState, validationState),
//                  title: Text(
//                    AppLocalizations.of(context)
//                        .translate("message_choose_city"),
//                    style: TextStyle(color: Theme.of(context).accentColor),
//                  ),
//                );
//              },
//            );
//          },
//        );
//      },
//    );
//  }
//
//  Widget _getStyledSubtitle(BuildContext context,
//      SelectionState<City> selectionState, ValidationState validationState) {
//    if (selectionState is SelectionItemSelected<City> &&
//        selectionState.selectedItem != null) {
//      return Text(
//        selectionState.selectedItem.name,
//        style: TextStyle(
//          fontSize: 20.0,
//          fontWeight: FontWeight.w400,
//          color: Colors.black,
//        ),
//      );
//    } else if (Provider.of<User>(context, listen: false).city != null) {
//      return Text(
//        Provider.of<User>(context, listen: false).city.name,
//        style: TextStyle(
//          fontSize: 20.0,
//          fontWeight: FontWeight.w400,
//          color: Colors.black,
//        ),
//      );
//    } else if (validationState is ValidationFailed &&
//        validationState.field == ValidationField.CITY) {
//      return Text(
//        "you forgot to select a city...",
//        style: TextStyle(color: Theme.of(context).errorColor),
//      );
//    } else
//      return Text("tap to select a city");
//  }
//
//  _setupModalBottomSheet(context) {
//    showModalBottomSheet(
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(10.0),
//      ),
//      context: context,
//      isDismissible: true,
//      builder: (newContext) {
//        /// Providing the existing User object because internally it creates
//        ///  a new route, which will not have current context information.
//        return Provider.value(
//          value: Provider.of<User>(context),
//          child: BlocProvider<CityBloc>(
//            create: (context) => CityBloc(),
//            child: Builder(
//              builder: (context) {
//                return CityListWidget(onCitySelected: (selectedCity) {
//                  Provider.of<User>(context, listen: false).city = selectedCity;
//                  BlocProvider.of<SelectionBloc<City>>(context)
//                      .add(SelectionSelectItem<City>(item: selectedCity));
//                });
//              },
//            ),
//          ),
//        );
//      },
//    );
//  }
//}
//
//class CityListWidget extends StatefulWidget {
//  final ValueChanged<City> onCitySelected;
//
//  CityListWidget({Key key, this.onCitySelected});
//
//  @override
//  State<StatefulWidget> createState() {
//    return _CityListState();
//  }
//}
//
//class _CityListState extends State<CityListWidget> {
//  @override
//  void initState() {
//    super.initState();
//    BlocProvider.of<CityBloc>(context).add(LoadCities());
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return BlocBuilder<CityBloc, CityState>(
//      builder: (context, state) {
//        if (state is CitiesLoaded) {
//          return ListView.separated(
//            shrinkWrap: true,
//            itemCount: state.cityList.length,
//            itemBuilder: (context, index) {
//              return ListTile(
//                title: Text(state.cityList[index].name),
//                onTap: () {
//                  widget.onCitySelected.call(state.cityList[index]);
//                  Navigator.pop(context);
//                },
//              );
//            },
//            separatorBuilder: (context, index) {
//              return Divider();
//            },
//          );
//        } else if (state is CityStateError) {
//          // TODO: Make error widget with retry option
//          throw UnimplementedError();
//        } else
//          return Center(child: CircularProgressIndicator());
//      },
//    );
//  }
//}
