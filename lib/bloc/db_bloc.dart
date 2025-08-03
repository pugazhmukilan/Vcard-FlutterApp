import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:visiting_card/DB/DB_init.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

part 'db_event.dart';
part 'db_state.dart';

class DbBloc extends Bloc<DbEvent, DbState> {
  
  DbBloc() : super(DbInitial()) {
    

    on<insertUser>((event, emit) async {
      DatabaseHelper  db = DatabaseHelper.getInstance();
     
      db.insertUser({
        'name': event.name,
        'profession': event.profession,
        'phonenumber': event.phonenumber,
        'email': event.email, 
        'gender': event.gender});
      
        List<Map<String, dynamic>> user  = await db.getUsers();
        emit(DBmodified(users: user));

  }
    );

    on<deleteUser>((event, emit) async {
      DatabaseHelper  db = DatabaseHelper.getInstance();
      db.deleteUser(event.id);
      List<Map<String, dynamic>> user  = await db.getUsers();
      emit(DBmodified(users: user));
    });

    on<GetAllUsers>((event, emit) async {
      DatabaseHelper db = DatabaseHelper.getInstance();
      List<Map<String, dynamic>> users = await db.getUsers();
      emit(DBmodified(users: users));
    });

}
}
