import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahagora_yazad/bloc/bloc.dart';


List<BlocProvider> blocProviders = [
  BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
  BlocProvider<HomeScreenCubit>(create: (context) => HomeScreenCubit()),
];