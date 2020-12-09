import 'package:flutter/material.dart';
import 'package:flutter_animation_test/item_details_screen.dart';
import 'package:flutter_animation_test/navigator_provider.dart';
import 'package:flutter_animation_test/riverpod_increment_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animation_test/riverpod_home_screen.dart';

import 'home_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          /*Consumer(builder: (context, watch, child) {
        print(watch(navProv).pages.length);
        return WillPopScope(
          onWillPop: () async {
            print("object");
            return context.read(navProv).onPop2();
          },
          child: Navigator(
            pages: watch(navProv).pages,
            onPopPage: (route, result) {
              return context.read(navProv).onPop2();
            },
          ),
        );
      })*/
          RiverpodIncrementScreen(),
    );
  }

  bool _onPopPage(
      Route<dynamic> route, dynamic result, NavigatorProvider pageManager) {
    pageManager.didPop(route.settings, result);
    return route.didPop(result);
  }
}
