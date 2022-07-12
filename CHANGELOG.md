## 0.10.0
- Added the ability to pass `dependencies` to `ViewModelProvider` which when changed, will recreate the `ViewModel`.

## 0.9.3
- Rename `viewModel` parameters to `vm`.

## 0.9.2
- Switch to `ReplaySubject` for ViewModel orders to handle situations where an order is emitted before a subscribing widget is built.

## 0.9.1

- Added a `const ViewModelOrder` constructor
- Made `ViewModelWidget.handleOrder` an optional override

## 0.9.0

Initial release

## 0.0.1
