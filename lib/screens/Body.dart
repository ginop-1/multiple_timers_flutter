import 'package:flutter/material.dart';
import '../models/Timer.dart';
import 'package:provider/provider.dart';

class Mainbody extends StatelessWidget {
  const Mainbody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index);

  @override
  Widget build(BuildContext context) {
    var timer = context.select<TimersModel, Timer>(
      (timers) => timers.getByPosition(index),
    );

    if (timer == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.all(2),
              color: Colors.blue[200],
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${timer.name}',
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({Key key}) : super(key: key);

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Timer'),
            content: TextField(
              controller: context.select<TimersModel, TextEditingController>(
                (timers) => timers.nameController,
              ),
              decoration: InputDecoration(hintText: "insert name here..."),
            ),
            actions: <Widget>[
              ElevatedButton(
                // color: Colors.green,
                // textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _displayTextInputDialog(context);
      },
      tooltip: 'Add Timer',
      child: Icon(Icons.add),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog'),
      floating: true,
    );
  }
}
