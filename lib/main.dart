import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQFLITE Example"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Name"
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "id"
            ),
          ),
          ElevatedButton(
              onPressed: (){
                createDatabase();
              },
              child: Text("Send Data")
          )
        ],
      ),
    );
  }

  void createDatabase() async{
    //database is database reference variable
    var database = await openDatabase("student.db");
    print("Database Created");
    createTable(database);
  }

  void createTable(Database database) async{
    await database.execute("create table if not exists studentInfo(name varchar (50),id varchar(30));");
    // if not exists (is use to create same table at each table without error)
    print("Table Created");
    insertValue(database);

  }

  void insertValue(Database database) async{
    await database.execute("insert into studentInfo values('Muskan Gupta','100')");
    print("one row(s) affected");
    fetchData(database);
  }

  void fetchData(Database database) async{
    var listData= await database.rawQuery("select * from studentInfo where id = '100'");
    print(listData.length);
    print(listData);
  }
}
