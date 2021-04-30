import 'package:veee/veee.dart';
import 'package:flutter_test/flutter_test.dart';

class TestViewModel extends ViewModel with ErrorViewModel {}

void main() async {
  test('hasError returns the correct value', () async {
    final vm = TestViewModel();
    expect(vm.hasError, false);
    vm.error = 'woah';
    expect(vm.hasError, true);
  });
}
