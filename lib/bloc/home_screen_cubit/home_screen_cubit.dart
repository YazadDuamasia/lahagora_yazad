import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lahagora_yazad/config/config.dart';
import 'package:lahagora_yazad/model/model.dart';
import 'package:lahagora_yazad/parser/parser.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial()) {
    getHomeScreenList();
  }

  void getHomeScreenList() async {
    try {
      emit(HomeScreenLoadingState());
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        emit(HomeScreenNoInternetState());
      } else {
        Map categoriesResult = await HttpCallGenerator.getApiCall(
            url:
                "http://myvbox.uk:2052/player_api.php?username=test&password=test1&action=get_vod_categories",
            header: jsonEncode(AppConfig.httpGetHeader));
        Map moviesResult = await HttpCallGenerator.getApiCall(
            url:
                "http://myvbox.uk:2052/player_api.php?username=test&password=test1&action=get_vod_streams",
            header: jsonEncode(AppConfig.httpGetHeader));

        if (categoriesResult["isError"] == true) {
          emit(HomeScreenErrorState(categoriesResult["response"]));
        } else if (moviesResult["isError"] == true) {
          emit(HomeScreenErrorState(moviesResult["response"]));
        } else {
          final categoryList =
              categoryModelFromJson(categoriesResult["response"]);
          final moviesList = moviesModelFromJson(moviesResult["response"]);

          Map<String, List<MoviesModel>> moviesByCategory =
              groupBy(moviesList, (movie) => movie.categoryId!);

          /*
          List<MoviesModel> actionMovies = moviesByCategory[1];
          * */


          emit(HomeScreenLoadedState(
              moviesByCategory: moviesByCategory,
              categoryList: categoryList,
              movieList: moviesList));
        }
      }
    } catch (e) {
      emit(HomeScreenErrorState(e.toString()));
    }
  }
}
