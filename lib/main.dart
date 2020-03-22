import 'package:flutter/material.dart';

import 'dog_model.dart';
import 'dog_card.dart';
import 'dog_list.dart';
import 'new_dog_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Rate Dogs',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: 'We Rate Dogs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var initialDogs = <Dog>[]
    ..add(Dog('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on furniture.'))
    ..add(Dog('Rex', 'Seattle, WA, USA', 'A Very Good Boy'))
    ..add(Dog('Rod Stewart', 'Prague, CZ', 'A Very Good Boy'))
    ..add(Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
    ..add(Dog('Buddy', 'North Pole, Earth', 'A Very Good Boy'));

  Future _showNewDogForm() async {
    Dog newDog = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext) {
      return AddDogFormPage();
    }));
    if (newDog != null) {
      initialDogs.add(newDog);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.black87,
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _showNewDogForm,
              )
            ]),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                0.1,
                0.5,
                0.7,
                0.9
              ],
                  colors: [
                Colors.deepPurple[800],
                Colors.deepPurple[700],
                Colors.deepPurple[600],
                Colors.deepPurple[400]
              ])),
          child: Center(
            child: DogList(initialDogs),
          ),
        ));
  }
}
