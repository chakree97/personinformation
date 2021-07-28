class InformationModel{
  int? id;
  String? name;
  String? tel;
  String? email;
  String? information;

  InformationModel({this.id,this.name,this.tel,this.email,this.information});

  Map<String,dynamic> toMap(){
    return({
      'id': id,
      'name': name,
      'tel': tel,
      'email': email,
      'information': information
    });
  }
}