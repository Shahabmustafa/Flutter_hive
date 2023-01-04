import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sqflite_have/Model/notes_model.dart';

import 'Boxes/boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive DataBase'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context,box,_){
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: box.length,
              itemBuilder: (context,index){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(data[index].title.toString()),
                          Spacer(),
                          InkWell(
                            onTap: (){
                              _editeDiolog(data[index], data[index].title.toString(), data[index].Description.toString());
                            },
                              child: Icon(Icons.edit)),
                          SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                            onTap: (){
                              delete(data[index]);
                              setState(() {

                              });
                            },
                              child: Icon(Icons.delete,color: Colors.red,),
                          ),
                        ],
                      ),
                      Text(data[index].Description.toString()),

                    ],
                  ),
                ),
              );
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          _showMyDiolog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void delete(NotesModel notesModel)async{
    await notesModel.delete();
  }


  Future <void> _showMyDiolog()async{
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
             title: Text('Add Notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        hintText: 'Description',
                      border:  OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    final data = NotesModel(
                        title: _titleController.text,
                        Description: _descriptionController.text,
                    );
                    final box = Boxes.getData();
                    box.add(data);
                    data.save();
                    _titleController.clear();
                    _descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Add')
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')
              ),
            ],
          );
        });
  }
  Future <void> _editeDiolog(NotesModel notesModel,String title,String description)async{
    _titleController.text = title;
    _descriptionController.text = description;
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Add Notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      border:  OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: ()async{
                    notesModel.title = _titleController.text.toString();
                    notesModel.Description = _descriptionController.text.toString();
                    notesModel.save();
                    Navigator.pop(context);
                  },
                  child: Text('edit')
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')
              ),
            ],
          );
        });
  }

}
