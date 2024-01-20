import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar: AppBar(
        title: const Text(
          'Add here, ',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w200),
        ),
        backgroundColor: Colors.indigo[300],
        elevation: 10,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey[400])),
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.grey[400])),
            maxLines: 8,
            minLines: 5,
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Save'))
        ],
      ),
    );
  }
}
