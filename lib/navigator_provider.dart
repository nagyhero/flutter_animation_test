import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animation_test/home_screen.dart';
import 'package:flutter_animation_test/item_details_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigatorProvider extends ChangeNotifier {
  List<Page> _pages = [
    MaterialPage(child: HomeScreen()),
  ];

  List<Page> get pages => List.unmodifiable(_pages);

  Completer<bool> _boolResultCompleter;

  void onHandelPage(page) {
    _pages.add(MaterialPage(child: page));
    notifyListeners();
  }

  Future<bool> onPop() async {
    _pages.removeAt(_pages.length - 1);
    print("from inside");
    notifyListeners();
    return false;
  }

  bool onPop2() {
    _pages.removeAt(_pages.length - 1);
    print("from inside");
    notifyListeners();
    return false;
  }

  void didPop(Page page, dynamic result) {
    _pages.remove(page);
    if (page is ResultablePage) {
      _setResult(result);
    }
    notifyListeners();
  }

  void _setResult(dynamic result) {
    if (result is bool && _boolResultCompleter != null) {
      _boolResultCompleter.complete(result);
    }
    if (result == null) {
      print('Result was null');
    }
  }
}

final navProv = ChangeNotifierProvider<NavigatorProvider>((ref) {
  return NavigatorProvider();
});

/// MaterialPage that is expected to return a result
class ResultablePage extends MaterialPage {
  const ResultablePage({
    @required Widget child,
    LocalKey key,
    String name,
  }) : super(
          key: key,
          name: name,
          child: child,
        );
}
