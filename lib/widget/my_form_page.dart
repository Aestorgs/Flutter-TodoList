import 'package:flutter/material.dart';

class MyFormPage extends StatefulWidget{
final String title;
 const MyFormPage({super.key , required this.title});
@override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyFormPage>{
  final _formKey = GlobalKey<FormState>();
  final myNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form")),
      body: Form( key: _formKey,
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.account_circle),
            hintText: 'Enter your name',
            labelText: 'Name',
          ),
          controller: myNameController,
          validator: (value) {
          if (value == null  || value.isEmpty ){
            return 'Please enter some text';
          } 
          return null;
        },),
        const Padding(padding : EdgeInsets.symmetric(vertical: 12)),
        ElevatedButton(onPressed: (){
          if(_formKey.currentState!.validate()){
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Hello , ${myNameController.text}')));
          }
        }, child: const Text('Submit'))
      ]),
      ),
    );
  }
}