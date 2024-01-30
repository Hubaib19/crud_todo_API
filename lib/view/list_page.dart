// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_app/view/add_page.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

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
          ),
        ),
        backgroundColor: Colors.indigo[300],
        elevation: 10,
      ),
      body: RefreshIndicator(
        onRefresh: fetchTodo,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index] as Map;
            final id = item['_id'] as String;
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(item['title']),
              subtitle: Text(item['description']),
              trailing: PopupMenuButton(
                onSelected: (value) {
                  if (value == 'edit') {
                    editPage(item);
                  } else if (value == 'delete') {
                    deleteById(id);
                  }
                },
                itemBuilder: (context) {
                  return [
                     PopupMenuItem(
                      child: Text('Edit'),
                      value: 'edit',
                    ),
                      PopupMenuItem(
                      child: Text('Delete'),
                      value: 'delete',
                    )
                  ];
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddPage()));
          setState(() {
            isLoading = true;
          });
          fetchTodo();
        },
        label: const Text('Add'),
      ),
    );
  }

  void editPage(Map item) {
    final route = MaterialPageRoute(builder: (context) => AddPage(todo :item));
    Navigator.push(context, route);
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    }
  }

  Future<void> fetchTodo() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
