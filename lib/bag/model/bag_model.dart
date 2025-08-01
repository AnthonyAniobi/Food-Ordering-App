import 'package:food_ordering_app/bag/model/bag_item.dart';

class BagModel {
  BagModel._();

  static final _instance = BagModel._();

  factory BagModel() => _instance;

  final List<BagItem> _items = [];

  Map<String, List<BagItem>> get groupedList {
    final Map<String, List<BagItem>> groupedItems = {};
    for (var item in _items) {
      groupedItems.putIfAbsent(item.restaurantName, () => []).add(item);
    }
    return groupedItems;
  }

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.price * item.quantity);

  void addToCart(BagItem cartItem) {
    bool itemExists = false;
    for (int index = 0; index < _items.length; index++) {
      final item = _items[index];
      if (item.productId == cartItem.productId &&
          item.details == cartItem.details) {
        _items[index].quantity += cartItem.quantity;
        itemExists = true;
        break;
      }
    }

    if (!itemExists) {
      _items.add(cartItem);
    }
  }

  void updateQuantity(String id, String detail, int quantity) {
    _items.map((item) {
      if (id == item.productId && detail == item.details) {
        return item.quantity = quantity;
      } else {
        return item;
      }
    }).toList();
  }

  void removeItem(String id, String details) {
    _items.removeWhere(
      (item) => item.productId == id && item.details == details,
    );
  }
}
