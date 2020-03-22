import 'package:flutter/material.dart';

import 'dog_model.dart';

class DogDetailPage extends StatefulWidget {
  final Dog dog;

  DogDetailPage(this.dog);

  @override
  _DogDetailPageState createState() => _DogDetailPageState();
}

class _DogDetailPageState extends State<DogDetailPage> {
  final double dogAvatarSive = 150.0;

  double _sliderValue = 10.0;

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: Colors.purpleAccent,
                  min: 0.0,
                  max: 15.0,
                  onChanged: (newRating) {
                    setState(() => _sliderValue = newRating);
                  },
                  value: _sliderValue,
                ),
              ),
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text(
                  "${_sliderValue.toInt()}",
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  Widget get submitRatingButton {
    return RaisedButton(
      onPressed: updateRating,
      child: Text("Submit"),
      color: Colors.purpleAccent,
    );
  }

  Widget get dogImage {
    return Container(
      height: dogAvatarSive,
      width: dogAvatarSive,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            const BoxShadow(
                offset: const Offset(1.0, 2.0),
                blurRadius: 2.0,
                spreadRadius: -1.0,
                color: const Color(0x33000000)),
            const BoxShadow(
                offset: const Offset(2.0, 1.0),
                blurRadius: 3.0,
                spreadRadius: 0.0,
                color: const Color(0x24000000)),
            const BoxShadow(
                offset: const Offset(3.0, 1.0),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                color: const Color(0x1F000000)),
          ],
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(widget.dog.imageUrl))),
    );
  }

  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.star,
          size: 40.0,
        ),
        Text(
          " ${widget.dog.rating} / 10",
          style: Theme.of(context).textTheme.display2,
        )
      ],
    );
  }

  void updateRating() {
    if (_sliderValue < 10) {
      _ratingErrorDialog();
    } else {
      setState(() => widget.dog.rating = _sliderValue.toInt());
    }
  }

  Widget get dogProfile {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.0),
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
            ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          dogImage,
          Text(
            "${widget.dog.name} 🎾",
            style: TextStyle(fontSize: 32.0),
          ),
          Text(
            widget.dog.location,
            style: TextStyle(fontSize: 20.0),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(widget.dog.description)),
          rating
        ],
      ),
    );
  }

  Future<Null> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Error"),
              content: Text("They're good dogs"),
              actions: [
                FlatButton(
                  child: Text("Try again"),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("Meet ${widget.dog.name}"),
        ),
        body: ListView(
          children: <Widget>[dogProfile, addYourRating],
        ));
  }
}
