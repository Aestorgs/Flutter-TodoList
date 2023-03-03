import 'package:apptodolist/widget/add_or_update_task.dart';
import 'package:flutter/material.dart';

import '../class/todo_list.dart';

class MyHomePage extends StatefulWidget{
 final String title;
 const MyHomePage({super.key , required this.title});
@override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

List<Task> taskList = [];
@override
  void initState(){
  taskList.add(Shopping("Kinder Bueno"));
  taskList.add(Sport("Triathlon"));
  taskList.add(Shopping("KitKat"));
  taskList.add(Sport("Trail"));
  taskList.add(Shopping("Nesquik"));
  taskList.add(Shopping("Mars"));
  taskList.add(Shopping("Twix"));
  taskList.add(Sport("Marathon"));
  taskList.add(Shopping("Bounty"));
   super.initState();
   }

  List<Widget> _drawTask(CategoryEnum category){
    return  taskList.where((el) => el.category == category) .map((task) => ListTile(
      leading: Checkbox(value: task.done,
      onChanged: (bool ? value){
        setState(() {
          task.done = value !;
        });
      }
      ),
      title: Text(task.name),
      trailing:
      Wrap(
      children:  <Widget>[
    IconButton(
       icon: const Icon(Icons.border_color),
       onPressed: () => _addOrUpdateTask(task)
    ),
     IconButton(
       icon: const Icon(Icons.delete),
       onPressed: (){
        setState(() {
          taskList.remove(task);
        });
       },
    ),
      ]
    )

    ) ).toList();
  }

 List<Widget> _drawTodoList(){
 List<Widget> result=[];
 for (CategoryEnum category in CategoryEnum.values){
  List<Widget> internalContainerListView =[];
  internalContainerListView.add(Container( margin : const EdgeInsets.all(12), child :Text(category.name.toUpperCase() , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),));
  internalContainerListView.addAll(_drawTask(category));
  result.add(Container(
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color:  Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5
      )
    ]),
    child: 
      ExpansionTile(
      title: Text(category.name.toUpperCase()),
      children: 
     _drawTask(category)
    ),
    ),
   );
  }
 return result;
 }

 void _addOrUpdateTask([Task? task]) async{
    Task? newTask =  await showDialog(context: context, builder: (_) => AddOrUpdateTaskPage(task : task)
    );
    if (newTask != null) {
      setState(() {
        if (task != null) {
          task.fromTask(newTask);
        } else {
          taskList.add(newTask);
        }
      });
    }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: ListView(
        children: _drawTodoList(),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () =>  _addOrUpdateTask(),
        child: const Icon(Icons.add),
      ), // Thi
    );
  }
}