import 'package:hive/hive.dart';
import 'package:machinetest/application/features/productMangement/models/cart_model.dart';

class CartService {
  final String _boxName = "cartBox";

  Future<Box<CartItem>> get _box async =>
      await Hive.openBox<CartItem>(_boxName);

  Future<void> addTodo(CartItem item) async {
    var box = await _box;
    await box.add(item);
  }

  Future<List<CartItem>> getAllTodos() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> deleteTodo(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

  Future<void> updateCartItem(int index, CartItem updatedItem) async {
    var box = await _box;
    await box.putAt(index, updatedItem);
  }
}
