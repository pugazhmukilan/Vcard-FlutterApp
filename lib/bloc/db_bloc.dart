import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:visiting_card/DB/DB_init.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

part 'db_event.dart';
part 'db_state.dart';

class DbBloc extends Bloc<DbEvent, DbState> {
  late Database db;
  DbBloc() : super(DbInitial()) {
    on<initializeDb>((event, emit)async {
      db = await initDatabase();
      print("Database initialized");
    });

    on<insertUser>((event, emit) async {
      await db.insert(
        'users',
        {
          'name': event.name,
          'profession': event.profession,
          'phonenumber': event.phonenumber,
          'email': event.email
        });
      emit(DBmodified());
  }
    );

    on<deleteUser>((event, emit) async {
      await db.delete(
        'users',
        where: 'id = ?',
        whereArgs: [event.id],
      );
      emit(DBmodified());
    });

}
}
