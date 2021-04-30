import 'view_model.dart';

mixin ErrorViewModel on ViewModel {
  String? error;
  bool get hasError => error != null;
}
