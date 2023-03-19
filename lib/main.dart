import 'package:flutter/material.dart';
import 'package:untitled/core/screen_utils.dart';
import 'package:untitled/ui/home_screen.dart';
import 'package:untitled/core/dependency_injection.dart' as get_it;

void main() async {
  get_it.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        ScreenUtils.init(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
        );
        return const MaterialApp(
          title: 'Mo Boom',
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        );
      },
    );
  }
}
