import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:personalinformation/model/model.dart';

final String tablename = 'service';
final String column_id = 'id';
final String column_name = 'name';
final String column_email = 'email';
final String column_tel = 'tel';
final String column_information = 'information';

class DatabaseService{
  Database? db;

  Future<Database> initDB() async{
    return db = await openDatabase(
      join(await getDatabasesPath(),'database.db'),
      onCreate: (db,version) async{
        return await db.execute('CREATE TABLE $tablename($column_id INTEGER PRIMARY KEY AUTOINCREMENT, $column_name TEXT, $column_email TEXT, $column_tel TEXT, $column_information TEXT)');
      },
      version: 1
    );
  }

  Future<void> insertDB(InformationModel info) async{
    final db = await initDB();
      await db.insert(tablename, info.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<InformationModel>> queryDB() async{
    final db = await initDB();
    final List<Map<String,dynamic>> task = await db.query(tablename);
    return List.generate(task.length, (index){
      return InformationModel(
        id: task[index][column_id],
        name: task[index][column_name],
        tel: task[index][column_tel],
        email: task[index][column_email],
        information: task[index][column_information]
      );
    });
  }

  Future<void> DeleteData(int id) async{
    final db = await initDB();
    db.delete(
      tablename,
      where: 'id= ?',
      whereArgs: [id]
    );
  }
}