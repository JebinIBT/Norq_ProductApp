import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:machinetest/application/features/productMangement/Database_Server/cart_service.dart';
import 'package:machinetest/application/features/productMangement/models/cart_model.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  Map<int, int> productCounts = {};

  @override
  Widget build(BuildContext context) {
    final CartService cartService = CartService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text("Cart Items", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: cartService.getAllTodos(),
          builder:
              (BuildContext context, AsyncSnapshot<List<CartItem>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ValueListenableBuilder(
                valueListenable: Hive.box<CartItem>('cartBox').listenable(),
                builder: (context, Box<CartItem> box, _) {
                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      var todo = box.getAt(index);
                      var count = productCounts[index] ??
                          1; // Get count for this item or default to 1
                      var totalPrice = (todo!.price * count);
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(todo.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        )),
                                  ),
                                  Text(
                                    '\$${(todo.price * count).toString()}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Quantity :  ",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors
                                                    .grey), // Add border styling here
                                            borderRadius: BorderRadius.circular(
                                                8), // Optional: Add border radius for rounded corners
                                          ),
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () {
                                                if (count > 1) {
                                                  setState(() {
                                                    productCounts[index] =
                                                        count - 1;
                                                  });
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          count.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors
                                                    .grey), // Add border styling here
                                            borderRadius: BorderRadius.circular(
                                                8), // Optional: Add border radius for rounded corners
                                          ),
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  productCounts[index] =
                                                      count + 1;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        cartService.deleteTodo(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
