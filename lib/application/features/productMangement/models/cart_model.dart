import 'package:hive/hive.dart';
part 'cart_item.g.dart';

@HiveType(typeId: 1)
class CartItem {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final int count;

  CartItem(
      {required this.title,
      required this.description,
      required this.price,
      required this.count});
}
