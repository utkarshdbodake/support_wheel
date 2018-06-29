import 'package:flutter/material.dart';

import 'package:flutter_buttons/flutter_buttons.dart';
import 'package:support_wheel/blocs/schedule_bloc.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScheduleBloc scheduleBloc = ScheduleProvider.of(context);

    return Scaffold(
        appBar: AppBar(
            title: Text('Change date'),
            centerTitle: true,
            backgroundColor: Colors.teal),
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                      onChanged: (text) {
                        print('scheduleBloc.dateSinkStream.add(text): $text');
                        scheduleBloc.dateSinkStream.add(text);
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.location_city),
                          labelText: 'Enter schedule start date',
                          hintText: '15-1-2018')),
                  SizedBox(
                    height: 30.0,
                  ),
                  KRaisedButton(
                      minWidth: 60.0,
                      radius: 30.0,
                      color: Colors.teal,
                      text: 'Change schedule start date',
                      textColor: Colors.white,
                      onPressed: () {
                        scheduleBloc.formSubmitSinkStream.add(null);
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ))

    );
  }
}
