import 'package:lahagora_yazad/pages/pages.dart';
import 'package:lahagora_yazad/routing/routs.dart';
import 'package:lahagora_yazad/utlis/utlis.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  /*
  *
  *  If want to pop all previous routes and move specific screen.
  *  Navigator.of(context).pushNamedAndRemoveUntil(RouteName.homeScreenRoute, (Route<dynamic> route) => false,);
  *
  */

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      // return MaterialPageRoute<dynamic>(builder: (_) => const SplashScreen());

      case RouteName.homeScreenRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          settings: settings,
          curve: Curves.easeInOut,
          child: const HomePage(),
        );
      case RouteName.viewMoreScreenRoute:
        Constants.debugLog(RouteGenerator,
            "viewMoreScreenRoute:arguments:${settings.arguments}");
        Map<String, dynamic>? argumentMap =
            settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          settings: settings,
          curve: Curves.easeInOut,
          child: ViewMoreHomeMoviePage(
            categoryModel: argumentMap["categoryModel"],
            movieList: argumentMap["list"],
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
