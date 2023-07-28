import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Attendence extends StatefulWidget {
  @override
  _AttendenceState createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> with TickerProviderStateMixin {
  CalendarFormat _calenderformat = CalendarFormat.week;
  DateTime _focusDay = DateTime.now();

  DateTime? _selectedDay;
  bool _isWeekend(DateTime day) {
    return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
  }

  int present = 04;
  int absent = 01;
  int per = 90;
  TextStyle _textStyle = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    TabController _tabcontroller = TabController(length: 2, vsync: this);
    DateTime _dayDate = _focusDay;
    String formattedDate = DateFormat('EEEE dd-MM-yyyy').format(_focusDay);
    // List ListItem = [];
    // final List<ListItem> items;
    int total = present + absent;
    double perc = (present / total) * 100;

    return Scaffold(
        appBar: AppBar(
          elevation: 0.8,
          title: Text(
            'Attendance',
            style: TextStyle(color: Colors.black),
          ),
          automaticallyImplyLeading: true,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 100,
                  width: 450,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          image: AssetImage("assets/Images/turtle.png"),
                          alignment: Alignment.bottomRight)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                    child: Text(
                      "Yay! Ruchika is Present today",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(25),
                    // image: DecorationImage(image: AssetImage("assets/Images/turtle.png"),alignment: Alignment.bottomRight)
                  ),
                  child: TableCalendar(
                    focusedDay: _focusDay,
                    // shouldFillViewport: false,
                    // headerVisible: false,

                    firstDay: DateTime(2023),
                    lastDay: DateTime(2024),
                    calendarFormat: _calenderformat,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    daysOfWeekHeight: 50,
                    headerStyle: HeaderStyle(
                      // formatButtonTextStyle: ,
                      // formatButtonDecoration: BoxDecoration(

                      //     image: DecorationImage(
                      //   image: AssetImage(
                      //     "assets/Images/turtle.png",
                      //   ),
                      // )),
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      headerPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      titleTextFormatter: (date, locale) =>
                          DateFormat.MMMM(locale).format(date),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      dowTextFormatter: (date, locale) =>
                          DateFormat.E(locale).format(date)[0],
                      weekendStyle: TextStyle(color: Colors.red),
                    ),
                    weekendDays: [DateTime.saturday, DateTime.sunday],

                    calendarBuilders: CalendarBuilders(
                      // singleMarkerBuilder: (context, date, _) {
                      //   return Container(
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: date == _focusDay
                      //             ? Colors.red
                      //             : Colors.blue), //Change color
                      //     width: 5.0,
                      //     height: 5.0,
                      //     margin: const EdgeInsets.symmetric(horizontal: 1.5),
                      //   );
                      // },
                    ),

                    calendarStyle: CalendarStyle(
                        canMarkersOverflow: true,
                        markerSize: 4,
                        weekendTextStyle: TextStyle(color: Colors.red),
                        selectedDecoration: BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        )),
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        _selectedDay = selectedDay;
                        _focusDay = focusedDay;
                        setState(() {});
                      }
                    },
                    selectedDayPredicate: (DateTime day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onFormatChanged: (format) {
                      if (_calenderformat != format) {
                        setState(() {
                          _calenderformat = format;
                        });
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Ruchika's Presence",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TabBar(
                      labelColor: Colors.black,
                      controller: _tabcontroller,
                      indicatorColor: Colors.grey,
                      tabs: [
                        Tab(text: "This Week"),
                        Tab(text: "This Month"),
                      ]),
                ),
              ),
              Container(
                height: 150,
                // width: 200,
                child: TabBarView(controller: _tabcontroller, children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      width: 450,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Text(
                              "Present \n   04",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 45,
                              child: VerticalDivider(
                                thickness: 1.8,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Absent \n   01",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 45,
                              child: VerticalDivider(
                                thickness: 1.5,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Percentage \n   $perc%",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      width: 450,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Text(
                              "Present \n   04",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 45,
                              child: VerticalDivider(
                                thickness: 1.8,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Absent \n   01",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 45,
                              child: VerticalDivider(
                                thickness: 1.5,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Percentage \n   $perc%",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Attendence Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 150,
                  width: 450,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                      // margin: EdgeInsets.all(15),
                      child: Column(children: [
                    ListTile(
                      title: Text("$formattedDate"),
                      trailing: Icon(
                        CupertinoIcons.check_mark_circled,
                        color: Colors.green,
                      ),
                      subtitle: Text("Arrived on time"),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                      dense: true,
                      title: Text(
                        "Dropped by - Mr.Sunil Patil",
                      ),
                      trailing: Text("- 08:24 am"),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                      dense: true,
                      title: Text(
                        "Picked up by - Mrs.Swati Patil",
                      ),
                      trailing: Text("- 12:03 pm"),
                    ),
                  ])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 150,
                  width: 450,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                    // margin: EdgeInsets.all(15),
                    child: Column(children: [
                      ListTile(
                        title: Text("$formattedDate"),
                        trailing: Icon(
                          CupertinoIcons.check_mark_circled,
                          color: Colors.green,
                        ),
                        subtitle: Text("Arrived on time"),
                      ),
                      ListTile(
                        visualDensity:
                            VisualDensity(vertical: -4, horizontal: 0),
                        dense: true,
                        title: Text(
                          "Dropped by - Mr.Sunil Patil",
                        ),
                        trailing: Text("- 08:24 am"),
                      ),
                      ListTile(
                        visualDensity:
                            VisualDensity(vertical: -4, horizontal: 0),
                        dense: true,
                        title: Text(
                          "Picked up by - Mrs.Swati Patil",
                        ),
                        trailing: Text("- 12:03 pm"),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _onDaySelected(DateTime day) {
   
    setState(() {
       _selectedDay = day;
    _focusDay = day;
    });
    //   if (!isSameDay(_selectedDay, selectedDay)) {
    //     _selectedDay = selectedDay;
    //     _focusDay = selectedDay;
    //     setState(() {});
    //   }
    // }
  }
}



//  Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 150,
//                   width: 450,
//                   // color: Colors.amber,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade200,
//                     borderRadius: BorderRadius.circular(35),
//                   ),
//                   child: Container(
//                     margin: EdgeInsets.all(15),
//                     child: Wrap(
//                       // mainAxisAlignment: MainAxisAlignment.center,
//                       alignment: WrapAlignment.spaceAround,
//                       runAlignment: WrapAlignment.center,
//                       children: [
//                         Text(
//                           "Present \n   04",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         SizedBox(
//                           height: 45,
//                           child: VerticalDivider(
//                             thickness: 1.8,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Text(
//                           "Absent \n   01",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         SizedBox(
//                           height: 45,
//                           child: VerticalDivider(
//                             thickness: 1.5,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Text(
//                           "Percentage \n   $per%",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),