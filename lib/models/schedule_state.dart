class Engineer {
  final String id;
  final String name;

  Engineer({this.id, this.name});

  @override
  String toString() => '''
    Engineer {
      id: $id,
      name: $name
    }
  ''';
}

class SingleDaySchedule {
  final String date;
  final List<Engineer> engineers;

  SingleDaySchedule({this.date, this.engineers});

  @override
  String toString() => '''
    SingleDaySchedule {
      date: $date,
      engineers: $engineers
    }
  ''';
}

class ScheduleState {
  final List<SingleDaySchedule> schedule;

  ScheduleState({this.schedule});

  ScheduleState.initial() : schedule = [];

  static ScheduleState fromJSON(Map<String, dynamic> data) {
    print(data);

    List<SingleDaySchedule> singleDaySchedules = [];
    int schedulePeriod = data["schedule"].length;

    for (int i = 0; i < schedulePeriod; i++) {
      List<Engineer> engineers = [];
      int totalEngineers = data["schedule"][i]["engineers"].length;
      for (int j = 0; j < totalEngineers; j++) {
        Engineer engineer = Engineer(
            id: data["schedule"][i]["engineers"][j]["id"],
            name: data["schedule"][i]["engineers"][j]["name"]);
        engineers.add(engineer);
      }

      SingleDaySchedule singleDaySchedule = SingleDaySchedule(
          date: data["schedule"][i]["date"], engineers: engineers);

      singleDaySchedules.add(singleDaySchedule);
    }

    return ScheduleState(schedule: singleDaySchedules);
  }

  @override
  String toString() => '''
    ScheduleState {
      schedule: $schedule
    }
  ''';
}
