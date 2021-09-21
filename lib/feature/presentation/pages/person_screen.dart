import 'package:flutter/material.dart';
import 'package:rick_and_morty/feature/presentation/widgets/persons_list_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            color: Colors.white,
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: PersonsList(),
    );
  }
}


