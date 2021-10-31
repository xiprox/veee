import 'package:flutter/material.dart';

import 'types.dart';
import 'view_model.dart';

/// A widget to provide a [ViewModel] to its descendants.
class ViewModelProvider<T extends ViewModel> extends StatefulWidget {
  /// Creator function to build a [ViewModel] to provide to descendants.
  final ViewModelCreator<T> create;

  final Widget child;

  const ViewModelProvider({
    Key? key,
    required this.create,
    required this.child,
  }) : super(key: key);

  static T find<T extends ViewModel>(BuildContext context) {
    final provider = context
        .findAncestorWidgetOfExactType<ViewModelProviderInheritedWidget<T>>();
    if (provider == null) {
      throw 'No ViewModelProvider found for $T';
    }
    return provider.viewModel;
  }

  @override
  _ViewModelProviderState<T> createState() => _ViewModelProviderState<T>();
}

class _ViewModelProviderState<T extends ViewModel>
    extends State<ViewModelProvider> {
  late T _viewModel;

  @override
  void initState() {
    _viewModel = widget.create(context) as T;
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProviderInheritedWidget(
      child: widget.child,
      viewModel: _viewModel,
    );
  }
}

class ViewModelProviderInheritedWidget<T extends ViewModel>
    extends InheritedWidget {
  final Widget child;
  final T viewModel;

  ViewModelProviderInheritedWidget({
    Key? key,
    required this.child,
    required this.viewModel,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(
    covariant ViewModelProviderInheritedWidget<T> oldWidget,
  ) {
    return oldWidget.viewModel != this.viewModel;
  }
}

/// Extension method on [BuildContext] to make it easier to access [ViewModel]s.
extension BuildContextViewModelProviderExt on BuildContext {
  T vm<T extends ViewModel>() => ViewModelProvider.find<T>(this);
}
