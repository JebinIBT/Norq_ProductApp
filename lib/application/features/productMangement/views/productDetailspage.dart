import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/application/features/productMangement/Database_Server/cart_service.dart';
import 'package:machinetest/application/features/productMangement/models/cart_model.dart';
import 'package:machinetest/application/features/productMangement/views/Common%20Widget/commonbutton.dart';

class ProductDetailsPage extends StatefulWidget {
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;
  final double rate;

  ProductDetailsPage({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.rate,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Image.network(widget.image)),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.title,
              maxLines: 3,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Price: \$${widget.price}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            CommonButton(
              title: 'Add to Cart',
              onClick: () async {
                var cart = CartItem(
                    title: widget.title,
                    description: widget.description,
                    price: widget.price,
                    count: 1);
                await _cartService.addTodo(cart);

                Navigator.pushNamed(context, '/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
