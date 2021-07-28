import 'package:flutter/material.dart';
import 'package:personalinformation/db/service.dart';
import 'package:personalinformation/model/model.dart';
import 'package:personalinformation/widget/home.dart';

class InsertInfo extends StatefulWidget {
  const InsertInfo({ Key? key }) : super(key: key);

  @override
  _InsertInfoState createState() => _InsertInfoState();
}

class _InsertInfoState extends State<InsertInfo> {

  TextEditingController NameControl = TextEditingController();
  TextEditingController TelControl = TextEditingController();
  TextEditingController EmailControl = TextEditingController();
  TextEditingController InformationControl = TextEditingController();
  DatabaseService dbService = DatabaseService();
  List<InformationModel> Infomodel = [];

  bool errName = false;
  bool errTel= false;
  bool errEmail = false;
  bool errInfo = false;

  Future<void> savedata(String name,String tel,String mail,String infomation) async{
    InformationModel infcon = InformationModel(name: name,tel: tel,email: mail,information: infomation);
    await dbService.insertDB(infcon);
    List<InformationModel> info =  await dbService.queryDB();
    
    for(var i=0;i<info.length;i++){
      print(info[i].name);
    }

    setState(() {
      Infomodel = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Insert Information'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Width*0.06,vertical: Height*0.04),
        child: Column(
          children: [
            TextField(
              controller: NameControl,
              decoration: InputDecoration(
                icon: Icon(Icons.person,color: Color(0xFF9A9CEA),),
                hintText: 'Please fill name',
                errorText: errName ? 'Name is empty Please fill your name':null
              ),
            ),
            SizedBox(height: Height*0.02,),
            TextField(
              controller: TelControl,
              decoration: InputDecoration(
                icon: Icon(Icons.call,color: Color(0xFFA2B9EE),),
                hintText: 'Please fill name',
                errorText: errTel ? 'Tel is empty Please fill your tel':null
              ),
            ),
            SizedBox(height: Height*0.02,),
            TextField(
              controller: EmailControl,
              decoration: InputDecoration(
                icon: Icon(Icons.mail,color: Color(0xFFA2DCEE),),
                hintText: 'Please fill name',
                errorText: errEmail ? 'Email is empty Please fill your email':null
              ),
            ),
            SizedBox(height: Height*0.02,),
            TextField(
              controller: InformationControl,
              maxLength: 500,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                icon: Icon(Icons.edit,color: Color(0xFF97CFBB),),
                hintText: 'Please fill name',
                helperText: 'Maximum 500 characters',
                errorText: errInfo ?'Information is empty Please fill your information':null
              ),
            ),
            SizedBox(height: Height*0.06,),
            Container(
              height: Width*0.12,
              width: Width*0.6,
              decoration: BoxDecoration(
                color: Color(0xFF37BC9B),
                borderRadius: BorderRadius.circular(4.0)
              ),
              child: FlatButton(
                child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 20),),
                onPressed: (){
                  if(NameControl.text.isEmpty){
                    setState(() {
                      errName = true;
                    });
                  }
                  else{
                    setState(() {
                      errName = false;
                    });
                  }
                  if(TelControl.text.isEmpty){
                    setState(() {
                      errTel = true;
                    });
                  }
                  else{
                    setState(() {
                      errTel = false;
                    });
                  }
                  if(EmailControl.text.isEmpty){
                    setState(() {
                      errEmail = true;
                    });
                  }
                  else{
                    setState(() {
                      errEmail = false;
                    });
                  }
                  if(InformationControl.text.isEmpty){
                    setState(() {
                      errInfo = true;
                    });
                  }
                  else{
                    setState(() {
                      errInfo = false;
                    });
                  }
                  if(errName == false && errTel == false && errEmail == false && errInfo == false){
                    savedata(NameControl.text, TelControl.text, EmailControl.text, InformationControl.text);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (BuildContext context)=>Home()),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
