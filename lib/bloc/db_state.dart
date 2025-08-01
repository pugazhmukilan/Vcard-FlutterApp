part of 'db_bloc.dart';

@immutable
sealed class DbState {}

final class DbInitial extends DbState {}
final class DBmodified extends DbState{}