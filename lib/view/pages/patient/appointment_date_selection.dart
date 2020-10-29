import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentDateSelection extends StatelessWidget {
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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24.0,
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
            height: 8.0,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TimeSlotSelector(),
          )),
          Divider(
            height: 2.0,
          ),
          CalendarDateSelector(),
          SizedBox(
            height: 16.0,
          ),
          ContinueToPaymentButton(),
        ],
      )),
    );
  }
}

class CalendarDateSelector extends StatefulWidget {
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
    print('CALLBACK: _onDaySelected');
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
}

class TimeSlotSelector extends StatefulWidget {
  @override
  _TimeSlotSelectorState createState() => _TimeSlotSelectorState();
}

class _TimeSlotSelectorState extends State<TimeSlotSelector> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [..._buildTimeSlotChips()],
    );
  }

  List<Widget> _buildTimeSlotChips() {
    List<Widget> chips = List();
    for (var i = 0; i < 10; i++) {
      chips.add(ChoiceChip(
        selected: i == _selectedIndex,
        selectedColor: Colors.blue,
        onSelected: (selected) {
          setState(() {
            _selectedIndex = i;
          });
        },
        label: Text(
          "10:30 AM",
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
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {},
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
