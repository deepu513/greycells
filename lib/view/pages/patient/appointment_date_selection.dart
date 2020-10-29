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
          MeetingMetaInfo(),
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
            ),
          ),
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

class MeetingMetaInfo extends StatelessWidget {
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
              "One on one meeting with Dr. Anne Hathaway for 60 minutes.",
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
    for (var i = 0; i < 7; i++) {
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

//TODO: Ask a confirmation from user before proceeding.
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
