part of 'info_bloc.dart';

@immutable
sealed class InfoState {}

final class InfoInitial extends InfoState {}
final class detailsInSufficent extends InfoState{
  
}
final class detailsSufficent extends InfoState{
   final String name;
   final String designation;
   final String email;
   final String phonenumber;
  detailsSufficent({required this.name,required this.designation, required this.email, required this.phonenumber});
}
