import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension TesterExts on WidgetTester {
  Future pumpWrapped(Widget child) {
    return pumpWidget(TestApp(child));
  }
}

class TestApp extends StatelessWidget {
  final Widget child;

  TestApp(this.child);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: child);
  }
}
