//import 'package:apptodolist/widget/my_form_page.dart';
import 'package:apptodolist/models/tasks_model.dart';
import 'package:apptodolist/widget/my_form_page.dart';
import 'package:apptodolist/widget/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    String title = "TodoList";
     return ChangeNotifierProvider(
      create: (_) => TasksModel(),
      child: Consumer<TasksModel>(builder: (_,__, ___) => MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title,),
      )
      )
     );
  }
}