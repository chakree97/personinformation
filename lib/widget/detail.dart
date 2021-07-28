import 'package:flutter/material.dart';
import 'package:personalinformation/db/service.dart';
import 'package:personalinformation/widget/home.dart';

class Detail extends StatefulWidget {
  final int? id;
  final String? name;
  final String? tel;
  final String? email;
  final String? information;
  const Detail({ Key? key ,this.id,this.name,this.tel,this.email,this.information}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  DatabaseService dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name!),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              dbService.DeleteData(widget.id!);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (BuildContext context)=>Home()),
                (Route<dynamic> route) => false,
              );
            },
          )
        ],
        actionsIconTheme: IconThemeData(
          color: Colors.white
        )
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Width*0.06,
          vertical: Height*0.04
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Name :"),
                trailing: Text(widget.name!),
              ),
            ),
            SizedBox(height: Height*0.02,),
            Card(
              child: ListTile(
                leading: Icon(Icons.call),
                title: Text("Tel :"),
                trailing: Text(widget.tel!),
              ),
            ),
            SizedBox(height: Height*0.02,),
            Card(
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text("Email :"),
                trailing: Text(widget.email!),
              ),
            ),
            SizedBox(height: Height*0.02,),
            Container(
              width: Width,
              height: Height*0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 0,
                    spreadRadius: 1,
                    offset: Offset(0, 2)
                  ),
                ]
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                     Text('Information:',style: TextStyle(fontSize: 20.0,color: Colors.black87),),
                     SizedBox(
                       height: 20.0,
                     ),
                     Text(widget.information!,style: TextStyle(fontSize: 18.0,color: Colors.black87),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}