import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import 'package:support_wheel/models/schedule_state.dart';
import 'package:support_wheel/dao/schedule_dao.dart';

class ScheduleBloc {

  static String _date = '';

  // input streams
  final BehaviorSubject<String> _dateStream = BehaviorSubject<String>();
  final BehaviorSubject _formSubmitStream = BehaviorSubject();
  Sink<String> get dateSinkStream => _dateStream.sink;
  Sink get formSubmitSinkStream => _formSubmitStream.sink;

  // output streams
  final BehaviorSubject<ScheduleState> _scheduleStateBehaviourSubject = BehaviorSubject<ScheduleState>();
  Stream<ScheduleState> get scheduleStateStream => _scheduleStateBehaviourSubject.stream;

  ScheduleBloc() {

    // Trigger the 1st fetch of ScheduleState.
    _formSubmitStream.add('');

    _formSubmitStream.stream.listen((_) {
      ScheduleDao
          .getSchedule(_date)
          .then((ScheduleState scheduleState) => _scheduleStateBehaviourSubject.add(scheduleState));
      _date = '';
    });

    _dateStream.stream.listen((String date) => _date = date);
  }

  void dispose() {
    _dateStream.close();
    _formSubmitStream.close();
    _scheduleStateBehaviourSubject.close();
  }
}

class ScheduleProvider extends InheritedWidget {
  final ScheduleBloc scheduleBloc;

  ScheduleProvider(
      {Key key, @required ScheduleBloc scheduleBloc, @required Widget child})
      : this.scheduleBloc = scheduleBloc ?? ScheduleBloc(),
        super(key: key, child: child);

  static ScheduleBloc of(BuildContext context) {
    ScheduleProvider scheduleProvider = (context
        .inheritFromWidgetOfExactType(ScheduleProvider) as ScheduleProvider);
    return scheduleProvider.scheduleBloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
