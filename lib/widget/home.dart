import 'package:flutter/material.dart';
import 'package:personalinformation/db/service.dart';
import 'package:personalinformation/model/model.dart';
import 'package:personalinformation/widget/detail.dart';
import 'package:personalinformation/widget/insertinfo.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DatabaseService dbService = DatabaseService();
  List<InformationModel> Infomodel = [];

  @override 
  void initState(){
    getallData();
    super.initState();
  }

  Future<void> getallData() async{
    List<InformationModel> info =  await dbService.queryDB();
    setState(() {
      Infomodel = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Person list'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Width*0.06,vertical: Height*0.04),
        child: (Infomodel.length == 0)?
          Center(
            child: Text("No Information"),
          ):
          ListView.builder(
            itemCount: Infomodel.length,
            itemBuilder: (BuildContext context,int index){
              return Card(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(Infomodel[index].name!),
                  subtitle: Text(Infomodel[index].tel!),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)=>
                          Detail(
                            id: Infomodel[index].id,
                            name: Infomodel[index].name,
                            tel: Infomodel[index].tel,
                            email: Infomodel[index].email,
                            information: Infomodel[index].information,
                          )
                        )
                      );
                    },
                  ),
                ),
              );
            }
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          Navigator.push(context, 
            MaterialPageRoute(
              builder: (BuildContext context)=>InsertInfo()
            )
          );
        },
      ),
    );
  }
}