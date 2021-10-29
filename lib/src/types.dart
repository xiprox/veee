import 'package:flutter/widgets.dart';

import 'view_model.dart';

/// Function signature for creating [ViewModel] instances.
typedef T ViewModelCreator<T extends ViewModel>(BuildContext context);

/// Function signature for building children of [ViewModelBuilder]s
typedef Widget ViewModelChildBuilder<T extends ViewModel>(
  BuildContext context,
  T viewModel,
  Widget child,
);

/// Function signature for [ViewModelOrder] handlers.
typedef ViewModelOrderHandler<T extends ViewModel>(
  ViewModelOrder order,
  T viewModel,
);
