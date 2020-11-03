import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/timeslot/timeslot_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/payment/payment.dart';
import 'package:greycells/models/payment/payment_item.dart';
import 'package:greycells/models/payment/payment_type.dart';
import 'package:greycells/models/therapist/charge.dart';
import 'package:greycells/models/therapist/therapist.dart';
import 'package:greycells/models/timeslot/timeslot.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentDateSelection extends StatelessWidget {
  final Therapist therapist;
  final MeetingCharge selectedMeeting;

  AppointmentDateSelection(this.therapist, this.selectedMeeting);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
        elevation: 4.0,
      ),
      body: SafeArea(
        child: MainContent(therapist, selectedMeeting),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  final Therapist therapist;
  final MeetingCharge selectedMeeting;

  MainContent(this.therapist, this.selectedMeeting);

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  Timeslot mSelectedTimeslot;
  DateTime mSelectedDay;

  @override
  void initState() {
    super.initState();
    mSelectedDay = DateTime.now();
    _getTimeslotsForDay(mSelectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MeetingMetaInfo(
          meetingType: widget.selectedMeeting.meetingType,
          therapistName:
              "${widget.therapist.user.firstName} ${widget.therapist.user.lastName}",
          duration: widget.therapist.meetingDuration.toString(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Available Timeslots",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocConsumer<TimeslotBloc, TimeslotState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is TimeslotsLoaded) {
                  return TimeSlotSelector(
                    availableTimeSlots: state.availableTimeslots,
                    onTimeslotSelected: (selectedTimeslot) {
                      mSelectedTimeslot = selectedTimeslot;
                    },
                  );
                }
                if (state is TimeslotsLoading)
                  return CenteredCircularLoadingIndicator();
                if (state is TimeslotsEmpty) return TimeslotsNotAvailable();
                if (state is TimeslotLoadError)
                  return TimeslotLoadErrorWidget(() {
                    _getTimeslotsForDay(mSelectedDay);
                  });

                return Container();
              },
            ),
          ),
        ),
        Divider(
          height: 2.0,
        ),
        CalendarDateSelector(
          onDaySelected: (day) {
            mSelectedDay = day;
            _getTimeslotsForDay(mSelectedDay);
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        ContinueToPaymentButton(() {
          if (mSelectedTimeslot != null) {
            final payment = Payment()
              ..type = PaymentType.APPOINTMENT
              ..title = "Book Appointment"
              ..itemImageUrl =
                  "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"
              ..itemTitle =
                  "${widget.therapist.user.firstName} ${widget.therapist.user.lastName}"
              ..itemSubtitle = widget.therapist.therapistType.name
              ..promoCodeApplied = false
              ..discountAmount = 0
              ..originalAmount = widget.selectedMeeting.amount
              ..items = [
                PaymentItem()
                  ..itemName = "1 Session"
                  ..itemPrice = widget.selectedMeeting.amount
              ]
              ..totalAmount = widget.selectedMeeting.amount;
            Navigator.of(context)
                .pushNamed(RouteName.PAYMENT_PAGE, arguments: payment);
          }
        }),
      ],
    );
  }

  void _getTimeslotsForDay(DateTime day) {
    BlocProvider.of<TimeslotBloc>(context).add(
        LoadTimeslotsForTherapist(widget.therapist.id, _getStringDate(day)));
  }

  String _getStringDate(DateTime day) {
    try {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      return dateFormat.format(day);
    } catch (e) {
      print(e);
    }
    return "";
  }
}

class TimeslotsNotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("No slots available on this day",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold)),
          Text("Please try selecting another day to book your appointment",
              style: Theme.of(context).textTheme.bodyText1)
        ],
      ),
    );
  }
}

class TimeslotLoadErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  TimeslotLoadErrorWidget(this.onRetry);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Something went wrong!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          SizedBox(
            height: 8.0,
          ),
          Text("Please try again in sometime.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  height: 1.3,
                  letterSpacing: 0.5,
                  wordSpacing: 0.7,
                  color: Colors.grey)),
          SizedBox(
            height: 16.0,
          ),
          OutlineButton(
            onPressed: onRetry,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 36.0),
            child: Text(
              Strings.retry.toUpperCase(),
            ),
          )
        ],
      ),
    );
  }
}

class MeetingMetaInfo extends StatelessWidget {
  final String meetingType;
  final String therapistName;
  final String duration;

  const MeetingMetaInfo(
      {Key key,
      @required this.meetingType,
      @required this.therapistName,
      @required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Colors.teal.shade700,
            size: 20.0,
          ),
          SizedBox(width: 8.0),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              "$meetingType meeting with $therapistName for $duration.",
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.teal.shade600, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarDateSelector extends StatefulWidget {
  final ValueChanged<DateTime> onDaySelected;
  CalendarDateSelector({@required this.onDaySelected});

  @override
  _CalendarDateSelectorState createState() => _CalendarDateSelectorState();
}

class _CalendarDateSelectorState extends State<CalendarDateSelector>
    with TickerProviderStateMixin {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
      availableCalendarFormats: {
        CalendarFormat.month: 'Month',
      },
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blue,
        todayColor: Colors.blue.shade200,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          rightChevronIcon: Icon(
            Icons.chevron_right_rounded,
            color: Colors.black87,
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left_rounded,
            color: Colors.black87,
          )),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    widget.onDaySelected.call(day);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {}

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {}

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
}

class TimeSlotSelector extends StatefulWidget {
  final ValueChanged<Timeslot> onTimeslotSelected;
  final List<Timeslot> availableTimeSlots;

  TimeSlotSelector(
      {@required this.availableTimeSlots, @required this.onTimeslotSelected});

  @override
  _TimeSlotSelectorState createState() => _TimeSlotSelectorState();
}

class _TimeSlotSelectorState extends State<TimeSlotSelector> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8.0,
      runSpacing: 4.0,
      children: [..._buildTimeSlotChips()],
    );
  }

  List<Widget> _buildTimeSlotChips() {
    List<Widget> chips = List();
    for (var i = 0; i < widget.availableTimeSlots.length; i++) {
      chips.add(ChoiceChip(
        selected: i == _selectedIndex,
        selectedColor: Colors.blue,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedIndex = i;
            });
            widget.onTimeslotSelected.call(widget.availableTimeSlots[i]);
          }
        },
        label: Text(
          widget.availableTimeSlots[i].startTime,
        ),
        labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              color: i == _selectedIndex ? Colors.white : Colors.black54,
            ),
      ));
    }
    return chips;
  }
}

class ContinueToPaymentButton extends StatelessWidget {
  final VoidCallback onProceedClicked;
  ContinueToPaymentButton(this.onProceedClicked);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: onProceedClicked,
        color: Theme.of(context).primaryColor,
        height: 56.0,
        minWidth: double.maxFinite,
        child: Text(
          "PROCEED TO PAYMENT".toUpperCase(),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                wordSpacing: 1.0,
                letterSpacing: 0.75,
                color: Colors.white,
              ),
        ));
  }
}
