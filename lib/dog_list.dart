import 'package:flutter/material.dart';

import 'dog_card.dart';
import 'dog_model.dart';

class DogList extends StatelessWidget {
  final List<Dog> dogs;

  DogList(this.dogs);

  ListView _buildList(context) {
    return ListView.builder(
        itemCount: dogs.length,
        itemBuilder: (context, int) {
          return DogCard(dogs[int]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
