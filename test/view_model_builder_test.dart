import 'package:veee/veee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'common.dart';

class TestViewModelOrder extends ViewModelOrder {}

class TestViewModel extends ViewModel {
  String? text;

  @override
  void dispose() {
    super.dispose();
  }
}

void main() {
  testWidgets('Rebuilds child when viewModel updates', (tester) async {
    final vm = TestViewModel();

    int buildCount = 0;

    await tester.pumpWrapped(
      ViewModelProvider<TestViewModel>(
        create: (_) => vm,
        child: ViewModelBuilder<TestViewModel>(
          builder: (context, viewModel, child) {
            buildCount++;
            return Text(viewModel.text ?? '?');
          },
        ),
      ),
    );

    expect(buildCount, 1);
    expect(find.text('woah'), findsNothing);

    vm.text = 'woah';
    vm.notifyListeners();
    await tester.pump();

    expect(buildCount, 2);
    expect(find.text('woah'), findsOneWidget);
  });

  testWidgets('Correctly handles orders', (tester) async {
    final vm = TestViewModel();
    final handledOrders = <ViewModelOrder>[];

    await tester.pumpWrapped(
      ViewModelProvider<TestViewModel>(
        create: (_) => vm,
        child: ViewModelBuilder<TestViewModel>(
          orderHandler: (order, viewModel) => handledOrders.add(order),
          builder: (context, bloc, child) {
            return Text(bloc.text ?? '?');
          },
        ),
      ),
    );

    final order = TestViewModelOrder();
    expect(handledOrders, isEmpty);
    vm.order(order);
    await tester.pumpAndSettle(Duration(milliseconds: 20));
    expect(handledOrders, contains(order));
  });

  testWidgets('Correctly passes specified child to builder', (tester) async {
    final vm = TestViewModel();
    final key = ValueKey('hey');

    await tester.pumpWrapped(
      ViewModelProvider<TestViewModel>(
        create: (_) => vm,
        child: ViewModelBuilder<TestViewModel>(
          builder: (context, bloc, child) {
            return child;
          },
          child: Container(key: key),
        ),
      ),
    );

    expect(find.byKey(key), findsOneWidget);
  });
}
