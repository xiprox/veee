import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';

import 'view_model_order.dart';

export 'view_model_order.dart';

/// A base ViewModel implementation.
abstract class ViewModel extends ChangeNotifier {
  ViewModel() {
    onCreate();
  }

  /// A Stream that notifies the View with orders for it to handle. This is used
  /// for things like navigating to a different route, showing a dialog, and
  /// similar, which the ViewModel can't handle due to lack of [BuildContext].
  ///
  /// Don't forget to cancel your subscription to this stream once you are done.
  /// Or just use [ViewModelWidget], which handles subscribing to this stream,
  /// provides a nice API for defining event handling, and cancels subscription
  /// for you.
  ///
  /// We use [ReplaySubject] here because we want to get orders emitted before
  /// the subscribing widget was built (e.g. in [onCreate]).
  @visibleForTesting
  final orderController = ReplaySubject<ViewModelOrder>();

  Stream<ViewModelOrder> get orders => orderController.asBroadcastStream();

  /// Called only once when the ViewModel is created.
  void onCreate() {}

  /// Emits a [ViewModelOrder] for the View to handle.
  void order(ViewModelOrder order) {
    orderController.add(order);
  }

  @override
  @mustCallSuper
  void dispose() {
    orderController.close();
    super.dispose();
  }
}
