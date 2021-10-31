import 'view_model.dart';

/// A [ViewModel] that can have an error.
mixin ErrorViewModel on ViewModel {
  String? error;
  bool get hasError => error != null;
}
