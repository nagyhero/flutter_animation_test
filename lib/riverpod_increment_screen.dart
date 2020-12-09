import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class RiverpodIncrementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(builder: (context, watch, child) {
          return Text(watch(incrementProvider).value.toString());
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read(incrementProvider).increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}

final incrementProvider =
    ChangeNotifierProvider((ref) => IncrementChangeNotifier());

class IncrementChangeNotifier extends ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }
}
