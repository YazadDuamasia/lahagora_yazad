import 'package:flutter/material.dart';
import 'package:lahagora_yazad/utlis/utlis.dart';

class NoInternetPage extends StatefulWidget {
  String? errorMsg;
  final GestureTapCallback? onPressedRetryButton;

  NoInternetPage(
      {Key? key, required this.errorMsg, required this.onPressedRetryButton})
      : super(key: key);

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  Size? size;
  Orientation? orientation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    orientation = MediaQuery.of(context).orientation;
    return SizedBox(
      width: size!.width,
      height: size!.height,
      child: Center(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Theme(
              data: Theme.of(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    ErrorIcon.error,
                    size: 130,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,15,8.0,15),
                      child: Text(
                            "Something when wrong. Please try again.",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headlineSmall!
                          ..copyWith(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: widget.onPressedRetryButton,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal),
                    ),
                    child: const Text("Retry Again"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
