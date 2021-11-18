import 'package:flutter/material.dart';

import 'view_model.dart';
import 'view_model_builder.dart';

/// A [Widget] subclass to simplify the creationg of Widgets that use a
/// [ViewModel] higher up in the widget tree.
abstract class ViewModelWidget<T extends ViewModel> extends Widget {
  const ViewModelWidget({Key? key}) : super(key: key);

  @protected
  Widget build(BuildContext context, T viewModel);

  /// Override this method to handle orders.
  void handleOrder(
    BuildContext context,
    ViewModelOrder order,
    T viewModel,
  ) {}

  @override
  _DataProviderElement<T> createElement() => _DataProviderElement<T>(this);
}

class _DataProviderElement<T extends ViewModel> extends ComponentElement {
  _DataProviderElement(ViewModelWidget widget) : super(widget);

  @override
  ViewModelWidget get widget => super.widget as ViewModelWidget<T>;

  @override
  Widget build() {
    return Builder(
      builder: (context) {
        return ViewModelBuilder<T>(
          orderHandler: (order, viewModel) {
            widget.handleOrder(context, order, viewModel);
          },
          builder: (context, viewModel, child) {
            return widget.build(context, viewModel);
          },
        );
      },
    );
  }
}
