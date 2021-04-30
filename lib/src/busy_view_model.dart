import 'view_model.dart';

mixin BusyViewModel on ViewModel {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  runBusyFuture(Future future) async {
    _isBusy = true;
    notifyListeners();
    await future;
    _isBusy = false;
    notifyListeners();
  }

  setBusy(bool busy) {
    if (_isBusy == busy) return;
    _isBusy = busy;
    notifyListeners();
  }
}
