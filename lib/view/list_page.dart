import 'dart:js';

import 'package:flutter/material.dart';
import 'package:quiz_app/view/add_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Todo',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w200),
        )),
        backgroundColor: Colors.indigo[300],
        elevation: 10,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddPage()));},
        label: const Text('Add'),
      ),
    );
  }

}
