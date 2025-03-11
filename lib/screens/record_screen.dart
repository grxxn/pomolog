import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  DateTime _focusedDay = DateTime.now();
  late DateTime _firstDayOfMonth;
  late DateTime _lastDayOfMonth;

  @override
  void initState() {
    super.initState();
    setState(() {
      _firstDayOfMonth = DateTime(_focusedDay.year, 1, 1);
      _lastDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 32,
            ),
            Text(
              "2025년 3월의 토마토",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                "🍅",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: _firstDayOfMonth,
            lastDay: _lastDayOfMonth,
            headerVisible: false,
            pageAnimationEnabled: false,
            calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.red.shade400,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: isSameDay(_focusedDay, DateTime.now())
                      ? Colors.red.shade400
                      : Colors.transparent,
                  border: Border.all(color: Colors.red.shade400, width: 2),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  color: isSameDay(_focusedDay, DateTime.now())
                      ? Colors.white
                      : Colors.red.shade400,
                )),
            selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
          ),
          _focusedDay.isAfter(DateTime.now())
              ? const Text('아직 도래하지 않은 일자입니다')
              : const Text('🍅')
        ],
      ),
    );
  }
}
