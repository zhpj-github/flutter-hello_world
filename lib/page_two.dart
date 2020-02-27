import 'dart:collection';

import 'package:flutter/material.dart';

class InheritedProvide<T> extends InheritedWidget {
  InheritedProvide({@required this.data, Widget child}) : super(child: child);
  final T data;
  @override
  bool updateShouldNotify(InheritedProvide<T> old) {
    // TODO: implement updateShouldNotify
    return true;
  }
}

Type _typeOf<T>() => T;

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({Key key, this.data, this.child});
  final Widget child;
  final T data;

  static T of<T>(BuildContext context, {bool listen = true}) {
    final type = _typeOf<InheritedProvide<T>>();

    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvide<T>>(aspect: type)
        : context.getElementForInheritedWidgetOfExactType<InheritedProvide<T>>()?.widget
            as InheritedProvide<T>;

    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      new _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    // TODO: implement didUpdateWidget
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvide<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

class Item {
  Item(this.price, this.count);
  double price;
  int count;
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);
  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class Consumer<T> extends StatelessWidget {
  Consumer({
    Key key,
    @required this.builder,
    this.child,
  })  : assert(builder != null),
        super(key: key);

  final Widget child;

  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context),
    );
  }
}

class DemoTwo extends StatefulWidget {
  @override
  _DemoTwoState createState() => new _DemoTwoState();
}

class _DemoTwoState extends State<DemoTwo> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: ChangeNotifierProvider<CartModel>(
        data: new CartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Consumer<CartModel>(
                builder: (BuildContext context, cart) =>
                    Text("总价: ${cart.totalPrice}"),
              ),
              Builder(builder: (context) {
                print("RaisedButton build");

                return RaisedButton(
                  child: Text("添加商品"),
                  onPressed: () {
                    ChangeNotifierProvider.of<CartModel>(context, listen: false)
                        .add(Item(20.0, 1));
                  },
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
