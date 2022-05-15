import 'package:flutter/material.dart';
import '../models/Timer.dart';
import 'package:provider/provider.dart';

class Mainbody extends StatelessWidget {
  const Mainbody({Key key}) : super(key: key);

  Future<void> _displayTextInputDialog(BuildContext context) async {
    TextEditingController nameController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Timer'),
            content: TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "insert name here..."),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  String timerName = nameController.text;
                  if (timerName.isNotEmpty) {
                    context.read<TimersModel>().add(Timer(
                          name: timerName,
                          time: 0,
                        ));
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mainbody')),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _TimersList(),
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayTextInputDialog(context);
        },
        tooltip: 'Add Timer',
        child: Icon(Icons.add),
      ),
    );
  }
}

// TODO IMPLEMENT TIMER WIDGET
class _TimersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timers = context.watch<TimersModel>();

    return ListView.builder(
      itemCount: timers.timers.length,
      itemBuilder: (context, index) => ListTile(
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            timers.remove(timers.timers[index].id);
          },
        ),
        title: Text(
          timers.timers[index].name,
        ),
      ),
    );
  }
}
