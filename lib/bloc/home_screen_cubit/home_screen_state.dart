part of 'home_screen_cubit.dart';

abstract class HomeScreenState extends Equatable {
   HomeScreenState();
}

class HomeScreenInitial extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class HomeScreenLoadingState extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class HomeScreenLoadedState extends HomeScreenState {


  final List<MoviesModel>? movieList;
  final List<CategoryModel>? categoryList;
  Map<String, List<MoviesModel>?>? moviesByCategory;

  HomeScreenLoadedState({this.movieList,this.categoryList,this.moviesByCategory});

  @override
  // TODO: implement props
  List<Object?> get props => [movieList,categoryList,moviesByCategory];

}

class HomeScreenErrorState extends HomeScreenState {
  String? error;
  HomeScreenErrorState(this.error);
  @override
  List<Object> get props => [error!];
}

class HomeScreenNoInternetState extends HomeScreenState {
  @override
  List<Object> get props => [];
}
