import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lahagora_yazad/bloc/bloc.dart';
import 'package:lahagora_yazad/main.dart';
import 'package:lahagora_yazad/model/model.dart';
import 'package:lahagora_yazad/pages/pages.dart';
import 'package:lahagora_yazad/routing/routs.dart';
import 'package:lahagora_yazad/utlis/utlis.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size? size;
  Orientation? orientation;
  ScrollController? scrollController;
  var brightness;
  HomeScreenCubit? _homeScreenCubit;
  ThemeCubit? _themeCubit;

  Image? image1;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0);
    image1 = Image.asset("assets/images/broken_image.png", fit: BoxFit.fill);
    super.initState();
    var window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      WidgetsBinding.instance.handlePlatformBrightnessChanged();
      // This callback is called every time the brightness changes.
      brightness = window.platformBrightness;
    };
  }

  @override
  void didChangeDependencies() {
    precacheImage(image1!.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    orientation = MediaQuery.of(context).orientation;
    _homeScreenCubit = BlocProvider.of<HomeScreenCubit>(
      context,
      listen: false,
    );

    _themeCubit = BlocProvider.of<ThemeCubit>(
      context,
      listen: true,
    );

    return Theme(
      data: Theme.of(context),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text("Home", style: TextStyle(color: Colors.white)),
              actions: [
                FlutterSwitch(
                  toggleSize: 45.0,
                  value: Theme.of(context).brightness == Brightness.light
                      ? true
                      : false,
                  borderRadius: 30.0,
                  padding: 2.0,
                  activeToggleColor: const Color(0xFF6E40C9),
                  inactiveToggleColor: const Color(0xFF2F363D),
                  activeSwitchBorder: Border.all(
                    color: const Color(0xFF3C1E70),
                    width: 6.0,
                  ),
                  inactiveSwitchBorder: Border.all(
                    color: const Color(0xFFD1D5DA),
                    width: 6.0,
                  ),
                  activeColor: const Color(0xFF271052),
                  inactiveColor: Colors.white,
                  activeIcon: const Icon(
                    Icons.nightlight_round,
                    color: Color(0xFFF8E3A1),
                  ),
                  inactiveIcon: const Icon(
                    Icons.wb_sunny,
                    color: Color(0xFFFFDF5D),
                  ),
                  onToggle: (val) async {
                    context.read<ThemeCubit>().toggleTheme(
                        Theme.of(context).brightness == Brightness.light
                            ? true
                            : false);
                  },
                ),
              ],
              leadingWidth: 35,
              automaticallyImplyLeading: false,
            ),
            body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
              builder: (context, state) {
                if (state is HomeScreenNoInternetState) {
                  return NoInternetPage(
                    errorMsg: "No Internet Connection",
                    onPressedRetryButton: () {
                      _homeScreenCubit!.getHomeScreenList();
                    },
                  );
                }
                if (state is HomeScreenLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(strokeWidth: 3),
                  );
                }
                if (state is HomeScreenErrorState) {
                  Constants.debugLog(HomePage, "Error:${state.error}");
                  return ErrorPage(
                    errorMsg: state.error,
                    onPressedRetryButton: () {
                      _homeScreenCubit!.getHomeScreenList();
                    },
                  );
                }
                if (state is HomeScreenLoadedState) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                addAutomaticKeepAlives: false,
                                cacheExtent: 10,
                                itemCount: state.categoryList?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  CategoryModel? categoryModel =
                                      state.categoryList?[index];
                                  if (state.moviesByCategory!.containsKey(
                                      categoryModel!.categoryId ?? "")) {
                                    List<MoviesModel>? movieList =
                                        state.moviesByCategory?[
                                            categoryModel.categoryId];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      categoryModel
                                                              .categoryName ??
                                                          "",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      await onItemClick(
                                                          dataList: movieList,
                                                          categoryModel:
                                                              categoryModel);
                                                    },
                                                    style: TextButton.styleFrom(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                    ),
                                                    child:
                                                        const Text("View More"),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: size!.width,
                                                height: orientation ==
                                                        Orientation.portrait
                                                    ? 230
                                                    : 220,
                                                padding: const EdgeInsets.only(
                                                  left: 0.0,
                                                  top: 0.0,
                                                  right: 0.0,
                                                  bottom: 0.0,
                                                ),
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  addAutomaticKeepAlives: false,
                                                  primary: true,
                                                  shrinkWrap: true,
                                                  itemCount: movieList!
                                                          .isNotEmpty
                                                      ? movieList.length < 10
                                                          ? movieList.length
                                                          : 10
                                                      : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var movieModel =
                                                        movieList[index];
                                                    return SizedBox(
                                                      width: orientation ==
                                                              Orientation
                                                                  .portrait
                                                          ? size!.width * .35
                                                          : size!.width * .20,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: Material(
                                                            type: MaterialType
                                                                .transparency,
                                                            child: InkWell(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              onTap: () async {
                                                                movieItemClick(
                                                                    movieModel);
                                                              },
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(10.0),
                                                                        topRight:
                                                                            Radius.circular(10.0),
                                                                      ),
                                                                      child:
                                                                          FancyShimmerImage(
                                                                        imageUrl:
                                                                            movieModel.streamIcon ??
                                                                                "",
                                                                        errorWidget:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(15.0),
                                                                          child: Image.asset(
                                                                              "assets/images/broken_image.png",
                                                                              color: Theme.of(context).colorScheme.primary,
                                                                              fit: BoxFit.fill),
                                                                        ),
                                                                        boxFit:
                                                                            BoxFit.fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                  child: Padding(
                                                                                padding: const EdgeInsets.only(left: 5, right: 5.0),
                                                                                child: Text(
                                                                                  movieModel.title ?? "",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  maxLines: 2,
                                                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                                                                                ),
                                                                              ))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5.0),
                                                                              child: Text(
                                                                                "(${movieModel.year ?? "Unknown"})",
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 1,
                                                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ))
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: index ==
                                                        (state.categoryList
                                                            ?.length)
                                                    ? false
                                                    : true,
                                                child: const SizedBox(
                                                  height: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return ErrorPage(
                  errorMsg: "Something is wrong",
                  onPressedRetryButton: () {
                    _homeScreenCubit!.getHomeScreenList();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onItemClick(
      {List<MoviesModel>? dataList, CategoryModel? categoryModel}) async {
    Map<String, dynamic> argument = {
      "categoryModel": categoryModel,
      "list": dataList
    };
    await navigatorKey.currentState!
        .pushNamed(RouteName.viewMoreScreenRoute, arguments: argument);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void movieItemClick(MoviesModel movieModel) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${movieModel.title}"),
      ),
    );
  }
}
