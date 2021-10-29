import 'dart:async';

import 'package:flutter/material.dart';

import 'types.dart';
import 'view_model.dart';
import 'view_model_provider.dart';

class ViewModelBuilder<T extends ViewModel> extends StatefulWidget {
  final ViewModelChildBuilder<T> builder;
  final Widget? child;
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
  late T viewModel;
  StreamSubscription? _ordersSubscription;

  @override
  void initState() {
    super.initState();
    viewModel = context.vm<T>();
    viewModel.addListener(_onViewModelChange);
    if (widget.orderHandler != null) {
      _ordersSubscription = viewModel.orders.listen((order) {
        widget.orderHandler?.call(order, viewModel);
      });
    }
  }

  @override
  void dispose() {
    viewModel.removeListener(_onViewModelChange);
    _ordersSubscription?.cancel();
    super.dispose();
  }

  void _onViewModelChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      viewModel,
      widget.child ?? SizedBox.shrink(),
    );
  }
}
