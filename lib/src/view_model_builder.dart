import 'dart:async';

import 'package:flutter/material.dart';

import 'types.dart';
import 'view_model.dart';
import 'view_model_provider.dart';

/// Rebuilds children every time [ViewModel] of given type [T] changes.
class ViewModelBuilder<T extends ViewModel> extends StatefulWidget {
  /// Builder function to build children.
  final ViewModelChildBuilder<T> builder;

  /// Prebuilt widgets that will be passed to [builder].
  final Widget? child;

  /// Function to handle [ViewModelOrder]s with.
  final ViewModelOrderHandler<T>? orderHandler;

  const ViewModelBuilder({
    Key? key,
    required this.builder,
    this.child,
    this.orderHandler,
  }) : super(key: key);

  @override
  _ViewModelBuilderState<T> createState() => _ViewModelBuilderState<T>();
}

class _ViewModelBuilderState<T extends ViewModel>
    extends State<ViewModelBuilder<T>> {
  T? viewModel;
  StreamSubscription? _ordersSubscription;

  @override
  void dispose() {
    _detachFromCurrentViewModel();
    super.dispose();
  }

  void _attachToNewViewModel(T vm) {
    viewModel = vm;
    viewModel!.addListener(_onViewModelChange);
    if (widget.orderHandler != null) {
      _ordersSubscription = viewModel!.orders.listen((order) {
        widget.orderHandler?.call(order, viewModel!);
      });
    }
  }

  void _detachFromCurrentViewModel() {
    viewModel?.removeListener(_onViewModelChange);
    _ordersSubscription?.cancel();
  }

  void _onViewModelChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final latestViewModel = context.vm<T>(listen: true);
    if (latestViewModel != viewModel) {
      _detachFromCurrentViewModel();
      _attachToNewViewModel(latestViewModel);
    }

    return widget.builder(
      context,
      viewModel!,
      widget.child ?? SizedBox.shrink(),
    );
  }
}
