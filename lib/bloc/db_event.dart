part of 'db_bloc.dart';

@immutable
sealed class DbEvent {}
final class initializeDb extends DbEvent {}
final class insertUser extends DbEvent {
  final String name;
  final String profession;
  final String phonenumber;
  final String email;
  final String gender;
  insertUser({
    required this.name,
    required this.profession,
    required this.phonenumber,
    required this.email,
    required this.gender
  });
}
final class deleteUser extends DbEvent {
  final int id;
  deleteUser({required this.id});
}