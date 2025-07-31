import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visiting_card/utils/checkInfo.dart' ;

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc() : super(InfoInitial()) {
    on<CheckInfoPresentOrNot>((event, emit)async {
      //check if the details are present in the shared preferences
      bool is_there = await checkInfoForSharedPreferences();

      if (!is_there) {
        emit(detailsInSufficent());
        return;
      }
      final infoDetails =await  SharedPreferences.getInstance();
      
      
      String? name = infoDetails.getString("name");
      String? desigination = infoDetails.getString("profession");
      String? phonenumber = infoDetails.getString("phonenumber");
      String? email = infoDetails.getString("email");
      

      emit(detailsSufficent(name: name.toString(),
                              designation: desigination.toString(),
                              phonenumber: phonenumber.toString() ,
                              email: email.toString()));
      
      

    });
  }
}
