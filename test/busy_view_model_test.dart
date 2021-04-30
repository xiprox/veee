import 'dart:async';

import 'package:veee/veee.dart';
import 'package:flutter_test/flutter_test.dart';

class TestViewModel extends ViewModel with BusyViewModel {
  void doBusyWork() {
    runBusyFuture(Future.delayed(Duration(seconds: 1), () {}));
  }
}

void main() async {
  test('Notifies listeners with the correct value', () async {
    final vm = TestViewModel();
    expect(vm.isBusy, false);
    final controller = StreamController();
    vm.addListener(() => controller.sink.add(null));
    expectLater(
      controller.stream.map((_) => vm.isBusy),
      emitsInOrder([true, false]),
    ).then((value) => controller.close());
    vm.doBusyWork();
  });
}
