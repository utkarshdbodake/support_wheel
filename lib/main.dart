import 'package:flutter/material.dart';

import 'package:support_wheel/blocs/schedule_bloc.dart';
import 'package:support_wheel/themes/default_theme.dart';
import 'package:support_wheel/pages/schedule_page.dart';

void main() {
  runApp(SupportWheelApp());
}

class SupportWheelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScheduleProvider(
      scheduleBloc: ScheduleBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: defaultTheme,
        title: 'Schedule App',
        home: ScheduleMainPage(),
      ),
    );
  }
}
