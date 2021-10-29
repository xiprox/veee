import 'package:veee/src/types.dart';
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

class TestViewModelWidget extends ViewModelWidget<TestViewModel> {
  final ViewModelOrderHandler? orderHandler;

  TestViewModelWidget({this.orderHandler});

  @override
  void handleOrder(
    BuildContext context,
    ViewModelOrder order,
    TestViewModel viewModel,
  ) {
    return orderHandler?.call(order, viewModel);
  }

  @override
  Widget build(BuildContext context, TestViewModel viewModel) {
    return Text(viewModel.text ?? '?');
  }
}

void main() {
  testWidgets('Rebuilds child when viewModel updates', (tester) async {
    final vm = TestViewModel();

    await tester.pumpWrapped(
      ViewModelProvider<TestViewModel>(
        create: (_) => vm,
        child: TestViewModelWidget(),
      ),
    );

    expect(find.text('woah'), findsNothing);

    vm.text = 'woah';
    vm.notifyListeners();
    await tester.pump();

    expect(find.text('woah'), findsOneWidget);
  });

  testWidgets('Correctly handles orders', (tester) async {
    final vm = TestViewModel();
    final handledOrders = <ViewModelOrder>[];

    await tester.pumpWrapped(
      ViewModelProvider<TestViewModel>(
        create: (_) => vm,
        child: TestViewModelWidget(
          orderHandler: (order, viewModel) => handledOrders.add(order),
        ),
      ),
    );

    final order = TestViewModelOrder();
    expect(handledOrders, isEmpty);
    vm.order(order);
    await tester.pumpAndSettle(Duration(milliseconds: 20));
    expect(handledOrders, contains(order));
  });
}
