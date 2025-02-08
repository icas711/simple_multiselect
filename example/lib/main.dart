import 'package:flutter/material.dart';
import 'package:simple_multiselect/simple_multiselect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const MyHomePage(title: 'Demo Simple Multi Select'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    List<User> users = [
      User(id: '0', title: 'James', email: 'james@google.com'),
      User(id: '1', title: 'Henry', email: 'henry@google.com'),
      User(id: '2', title: 'Igor', email: 'igor@google.com'),
      User(id: '3', title: 'Maksim', email: 'maksim@google.com'),
      User(id: '4', title: 'Ava', email: 'ava@google.com'),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: SimpleMultiselect<User>(
            labelBackgroundColor: Colors.lightGreen.shade300,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            dataSource: users,
            onChange: (value) => print(value),
            closeButtonText: 'Close',
          ),
        ),
      ),
    );
  }
}

class User {
  final String id;
  final String title;
  final String email;

  const User({required this.id, required this.title, required this.email});

  @override
  String toString() {
    return title;
  }
}
