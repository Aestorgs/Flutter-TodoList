import 'package:apptodolist/class/todo_list.dart';
import 'package:flutter/material.dart';

class AddOrUpdateTaskPage extends StatefulWidget{
  final Task? task;
  const AddOrUpdateTaskPage({super.key ,  this.task});
@override
State<StatefulWidget> createState() => AddOrUpdateTaskPageState();
}
class AddOrUpdateTaskPageState extends State<AddOrUpdateTaskPage>{
  final formKey = GlobalKey<FormState>();
  final taskNamectrl = TextEditingController();
  final List<DropdownMenuItem>categoryItems = [];
  CategoryEnum seleledCategory = CategoryEnum.values.first;

  @override
  void initState() {
    categoryItems.addAll(
      List.generate(
        CategoryEnum.values.length,
        (index) => DropdownMenuItem(
          value: CategoryEnum.values[index],
          child: Text(CategoryEnum.values[index].name),
     ))
     );
     taskNamectrl.text = widget.task?.name ?? "";
     if(widget.task != null ){
      seleledCategory = widget.task!.category;
     }
      super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add or Update '),
      actions: [
        ElevatedButton(onPressed: (){
          if(formKey.currentState!.validate()){
          Task? newTask = widget.task;
          switch(seleledCategory){
            case CategoryEnum.shopping:
            newTask = Shopping(taskNamectrl.text);
            break;
             case CategoryEnum.sport:
            newTask = Sport(taskNamectrl.text);
            break;
             case CategoryEnum.work:
            newTask = Work(taskNamectrl.text);
            break;
          }
          Navigator.pop(context , newTask);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content : Text('new task created')));
          }
        }, child: const Text('submit'))
      ],
      content: Form(
        key:  formKey,
      
        child: Column(
          children: [
        TextFormField(
          decoration: const InputDecoration(label: Text('task name') , hintText: 'enter task name' 
          ),
          controller: taskNamectrl,
          validator: (value){
             if (value == null  || value.isEmpty ){
            return 'Please enter some text';
          } 
          return null;
          },),
          DropdownButtonFormField(items: categoryItems, value : seleledCategory, onChanged: (newValue) {
            seleledCategory = newValue!;
          },
          validator: (value) => null,
          ),
      ]),
      ),
    );
  }
}



