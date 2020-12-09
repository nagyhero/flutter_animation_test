import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class RiverpodHomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final greeting = watch(greetingProvider);

    return Scaffold(
      body: Center(
        child: Text(greeting),
      ),
    );
  }
}

final greetingProvider = Provider((ref) => "hello provider");
