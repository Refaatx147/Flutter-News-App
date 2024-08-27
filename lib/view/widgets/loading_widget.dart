import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({super.key});

  @override
  State<LoadingListPage> createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  @override
  Widget build(BuildContext context) {
    return const CardLoading(
      cardLoadingTheme:
          CardLoadingTheme(colorOne: Colors.black, colorTwo: Colors.black26),
      animationDuration: Duration(milliseconds: 750),
      curve: Curves.easeInOutCirc,
      height: 500,
      width: 500,
      withChangeDuration: false,
      borderRadius: BorderRadius.all(Radius.circular(50)),
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}
