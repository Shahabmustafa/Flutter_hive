import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive DataBase'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: Hive.openBox('Shahab'),
              builder: (context,snapshot){
              if(snapshot.hasData){
                return Text(snapshot.data!.get('name').toString());
              }else{
                return CircularProgressIndicator();
              }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          var box = await Hive.openBox('Shahab');
          
          box.put('name', 'Shahab Mustafa');
          print(box.get('name'));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
