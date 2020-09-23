import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var number = 0;

  @override
  void initState() {
    super.initState();
    getIntFromLocalMemory('COUNTER_NUMBER').then((value) =>
      number = value
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save data locally'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(onPressed: (){
              setState(() {
                number--;
              });
              saveIntInLocalMemory('COUNTER_NUMBER', number);
            },
            child: Text('-'),
            ),
            Padding(
              padding: const EdgeInsets.all(21.0),
              child: Text(number.toString()),
            ),
            RaisedButton(onPressed: () {
              setState(() {
                number++;
              });
              saveIntInLocalMemory('COUNTER_NUMBER', number);
            },
            child: Text('+'),
            )
          ],
        ),
      )
    );
  }

  /*
  * It saves the int value to the local memory.
  * */
  Future<int> getIntFromLocalMemory(String key) async {
    var pref = await SharedPreferences.getInstance();
    var number = pref.getInt(key) ?? 0;
    return number;
  }

  /*
  * It returns the saved the int value from the memory.
  * */
  Future<void> saveIntInLocalMemory(String key, int value) async {
    var pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }
}
