import 'package:flutter/material.dart';
import 'package:lahagora_yazad/model/model.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class ViewMoreHomeMoviePage extends StatefulWidget {
  CategoryModel? categoryModel;
  List<MoviesModel>? movieList;
  ViewMoreHomeMoviePage({Key? key, this.categoryModel, this.movieList})
      : super(key: key);

  @override
  State<ViewMoreHomeMoviePage> createState() => _ViewMoreHomeMoviePageState();
}

class _ViewMoreHomeMoviePageState extends State<ViewMoreHomeMoviePage> {
  Size? size;
  Orientation? orientation;
  Image? image1;

  @override
  void initState() {
    image1 = Image.asset("assets/images/broken_image.png", fit: BoxFit.fill);
    super.initState();
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
    return Theme(
      data: Theme.of(context),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leadingWidth: 35,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                widget.categoryModel?.categoryName ?? "",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
              ),
            ),
            body: LayoutBuilder(
              builder: (context,constraints) {
                return ResponsiveGridList(
                  horizontalGridMargin: 5,
                  verticalGridMargin: 5,
                  minItemsPerRow: 2,
                  maxItemsPerRow: 4,
                  minItemWidth: orientation == Orientation.portrait ? 200 : 230,
                  children:
                      List.generate(widget.movieList?.length ?? 0, (index) {
                    var movieModel = widget.movieList![index];
                    return Container(
                      height: orientation ==
                          Orientation.portrait
                          ? 230
                          : 220,
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
                                // movieItemClick(
                                //     movieModel);
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
                                      topLeft: Radius
                                          .circular(
                                          10.0),
                                      topRight:
                                      Radius.circular(
                                          10.0),
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
                                            color:
                                            Theme.of(context).colorScheme.primary,
                                            fit: BoxFit.fill),
                                      ),
                                      boxFit: BoxFit
                                          .fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
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
                                                padding: const EdgeInsets.only(
                                                    left: 5,
                                                    bottom: 5,
                                                    right: 5.0),
                                                child:
                                                Text(
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
                    );
                  },
                      ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    return Future.value(true);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
