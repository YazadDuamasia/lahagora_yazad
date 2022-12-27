import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahagora_yazad/bloc/theme_cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.light));


  /// Toggles the current brightness between light and dark.
  void toggleTheme(bool? isDarkMode) async {
    if (isDarkMode==true) {
      emit(ThemeState(themeMode: ThemeMode.dark));
    } else{
      emit(ThemeState(themeMode: ThemeMode.light));
    }
  }
  void themeSelector() async {
    if (state.themeMode== ThemeMode.dark) {
      emit(ThemeState(themeMode: ThemeMode.light));
    } else if(state.themeMode== ThemeMode.light) {
      emit(ThemeState(themeMode: ThemeMode.dark));
    }else if(state.themeMode== ThemeMode.system){
      emit(ThemeState(themeMode: ThemeMode.system));
    }else{
      emit(ThemeState(themeMode: ThemeMode.light));
    }
  }
}
