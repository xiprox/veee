import 'package:veee/veee.dart';
import 'package:flutter_test/flutter_test.dart';

class TestViewModelOrder extends ViewModelOrder {}

class TestViewModel extends ViewModel {
  int count = 0;
}

void main() async {
  test('Correctly updates', () async {
    final vm = TestViewModel();
    expect(vm.count, 0);
    vm.count = 1;
    vm.notifyListeners();
    expect(vm.count, 1);
  });

  test('Correctly disposes', () async {
    final vm = TestViewModel();
    vm.dispose();
    expect(vm.orderController.isClosed, true);
  });

  test('Correctly emits orders', () async {
    final vm = TestViewModel();
    final testEvent = TestViewModelOrder();
    expectLater(vm.orders, emits(testEvent));
    vm.order(testEvent);
  });
}
