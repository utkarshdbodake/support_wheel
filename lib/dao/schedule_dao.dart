import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:support_wheel/models/schedule_state.dart';
import 'package:support_wheel/constants/constants.dart' as constants;

class ScheduleDao {
  static final http.Client _httpClient = http.Client();
  static final String _scheduleURL = '${constants.scheduleAPI}';

  static Future<ScheduleState> getSchedule(String date) async {
    return _httpClient
        .post(Uri.parse(_scheduleURL),
            headers: {'x-api-key': constants.scheduleApiKey},
            body: json.encode({'startDate': date ?? ''}))
        .then((res) => res.body)
        .then(json.decode)
        .then((data) => ScheduleState.fromJSON(data))
        .catchError((error) => ScheduleState(schedule: []));
  }
}
