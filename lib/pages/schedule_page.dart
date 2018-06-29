import 'package:flutter/material.dart';
import 'package:flutter_buttons/flutter_buttons.dart';

import 'package:support_wheel/blocs/schedule_bloc.dart';
import 'package:support_wheel/models/schedule_state.dart';
import 'package:support_wheel/pages/form_page.dart';

class ScheduleMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScheduleBloc scheduleBloc = ScheduleProvider.of(context);

    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<bool>(
          initialData: false,
          stream: scheduleBloc.isLoadingStateStream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return Stack(
              children: <Widget>[
                Opacity(
                  opacity: snapshot.data ? 0.0 : 1.0,
                  child: _buildList(context, scheduleBloc),
                ),
                Center(
                  child: Opacity(
                    opacity: snapshot.data ? 1.0 : 0.0,
                    child: LinearProgressIndicator(),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, ScheduleBloc scheduleBloc) {
    return CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  onPressed: () => _openFormPage(context),
                ),
              ),
            ],
            snap: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Schedular',
                style: TextStyle(color: Colors.teal),
              ),
              centerTitle: true,
              background: Image.asset(
                'assets/images/schedular.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          StreamBuilder<ScheduleState>(
            initialData: ScheduleState.initial(),
            stream: scheduleBloc.scheduleStateStream,
            builder:
                (BuildContext context, AsyncSnapshot<ScheduleState> snapshot) {
              return SliverList(
                  delegate:
                      SliverChildListDelegate(_buildTextViews(snapshot.data)));
            },
          ),
        ]);
  }

  List _buildTextViews(ScheduleState scheduleState) {
    List<Widget> items = List();

    for (int i = 0; i < scheduleState.schedule.length; i++) {
      items.add(Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              '${scheduleState?.schedule[i]?.date}',
              style: TextStyle(fontSize: 20.0, color: Colors.teal),
            ),
            subtitle: _getEngineers(scheduleState.schedule[i].engineers),
          ),
          Divider()
        ],
      ));
    }

    return items;
  }

  Widget _getEngineers(List<Engineer> engineers) {
    if (engineers == null) {
      return Text('-');
    }

    String engineersStr = '\n';

    for (int i = 0; i < engineers.length; i++) {
      engineersStr += '${engineers[i].name}';
      if (i != engineers.length - 1) {
        engineersStr += '\n';
      }
    }

    return Text('Engineers: $engineersStr', style: TextStyle(fontSize: 15.0));
  }

  void _openFormPage(BuildContext context) {
    Route route = MaterialPageRoute(builder: (context) => FormPage());
    Navigator.of(context).push(route);
  }
}
