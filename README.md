# Veee

Veee is a simple MVVM package for Flutter without many bells and whistles. It's a solution to state management I've come up with while working on apps. I like how simple, clean, and flexible it is. It may not cover some complex scenarios out-of-the-box, but I personally have yet to get there.

The main reason I'm putting it up on GitHub is to host it for the apps I'm working on. It's not very well documented. You probably don't want to use it. However, if you stumbled upon it and have some opinions, or tried it and faced issues, I'd be happy to hear.

```yaml
dependencies:
  # ...
  veee:
    git:
      url: https://github.com/xiprox/veee
      ref: main
```

## How it looks

```dart

class ShowSnackbarOrder extends ViewModelOrder {
  final String message;
  ShowSnackbarOrder(this.message);
}

// ...

class CounterViewModel extends ViewModel {
  int count = 0;

  void onIncrementPress() {
    count++;
    notifyListeners();

    if (count == 5) {
      order(ShowSnackbarOrder('You have reached 5!'));
    }
  }
}

// ...

class CounterPage extends ViewModelWidget<CounterViewModel> {

  @override
  void handleOrder(BuildContext context, ViewModelOrder order) {
    if (order is ShowSnackbarOrder) {
      // Show snackbar
    }
  }

  @override
  Widget build(BuildContext context, CounterViewModel viewModel) {
    return Text('Count: ${viewModel.count}');
  }
}

// ...

class MyWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CounterViewModel>(
      orderHandler: (order) {
        if (order is ShowSnackbarOrder) {
          // Show a snackbar.
        }
      },
      builder: (context, viewModel, child) {
        return Text('Count: ${viewModel.count}');
      },
    );
  }
}

```