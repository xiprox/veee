import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veee/veee.dart';

import 'common.dart';

class TestViewModel extends ViewModel {
  bool disposed = false;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}

void main() {
  testWidgets('Correctly provides ViewModel', (tester) async {
    final vm = TestViewModel();

    TestViewModel? foundViewModel;

    await tester.pumpWrapped(
      ViewModelProvider<TestViewModel>(
        create: (_) => vm,
        child: Builder(
          builder: (context) {
            foundViewModel = context.vm<TestViewModel>();
            return Container();
          },
        ),
      ),
    );

    await tester.pumpAndSettle(Duration(milliseconds: 20));
    expect(foundViewModel, vm);
  });

  testWidgets('Correctly disposes of ViewModel', (tester) async {
    final vm = TestViewModel();

    await tester.pumpWrapped(
      ViewModelProvider<TestViewModel>(
        create: (_) => vm,
        child: Container(),
      ),
    );

    expect(vm.disposed, false);
    await tester.pumpWidget(Container());
    expect(vm.disposed, true);
  });
}
