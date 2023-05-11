import 'package:flutter/material.dart';
import 'package:snackstack/snackstack.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  SnackPosition position = SnackPosition.bottom;

  @override
  Widget build(BuildContext context) {
    final ThemeData appThemeData = ThemeData();

    return MaterialApp(
      theme: appThemeData,
      home: SnackstackWrapper(
        appThemeData: appThemeData,
        position: position,
        snackstackThemeData: const SnackstackThemeData(
          appearDuration: Duration(milliseconds: 400),
          resizeDuration: Duration(milliseconds: 200),
          tileTheme: SnackTileThemeData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.red,
                  spreadRadius: 2,
                  blurRadius: 3,
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Title'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: togglePosition,
                child: const Text('Toggle position'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: addEvent,
                child: const Text('Add event'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: addEvent2,
                child: const Text('Add event 2'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: addEvent3,
                child: const Text('Add event unique'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: addEvent4,
                child: const Text('Add event with tap handler'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void togglePosition() {
    setState(() {
      if (position == SnackPosition.bottom) {
        position = SnackPosition.top;
      } else {
        position = SnackPosition.bottom;
      }
    });
  }

  void addEvent() {
    SnackstackManager().add(SnackEvent(
      color: Colors.green,
      title: 'Test text',
    ));
  }

  void addEvent2() {
    SnackstackManager().add(SnackEvent(
      color: Colors.red,
      title: 'Test text 2',
      actions: [
        SnackAction(
          onPressed: () => print('pressed'),
          child: const Icon(Icons.info),
        ),
      ],
    ));
  }

  void addEvent3() {
    SnackstackManager().add(SnackEvent(
      color: Colors.purple,
      title: 'Test text 3',
      duration: const Duration(seconds: 30),
      unique: true,
    ));
  }

  void addEvent4() {
    SnackstackManager().add(SnackEvent(
      color: Colors.cyan,
      title: 'Test text 4',
      description: 'Tap on it and check debug console',
      duration: const Duration(seconds: 5),
      onTap: () => print('SUCESSFULLY TAPPED'),
    ));
  }
}
