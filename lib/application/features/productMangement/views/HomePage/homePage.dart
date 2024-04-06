import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinetest/application/features/productMangement/Database_Server/cart_service.dart';
import 'package:machinetest/application/features/productMangement/models/cart_model.dart';
import 'package:machinetest/application/features/productMangement/post_bloc/post_bloc.dart';
import 'package:machinetest/application/features/productMangement/views/productDetailspage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostBloc postBloc = PostBloc();

  @override
  void initState() {
    postBloc.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CartService cartService = CartService();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[400],
      ),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PostSuccessfulState) {
            final successState = state;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: successState.product.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            title: successState.product[index].title,
                            description:
                                successState.product[index].description,
                            price: successState.product[index].price,
                            category: successState.product[index].category,
                            image: successState.product[index].image,
                            rate: successState.product[index].rating.rate,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            child: IconButton(
                                onPressed: () async {
                                  var cart = CartItem(
                                      title: successState.product[index].title,
                                      description: successState
                                          .product[index].description,
                                      price: successState.product[index].price,
                                      count: 1);
                                  await cartService.addTodo(cart);
                                  Navigator.pushNamed(context, '/addproduct');
                                },
                                icon: const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.red,
                                )),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                      successState.product[index].image)),
                              const SizedBox(height: 5),
                              Text(
                                successState.product[index].title,
                                maxLines: 2, // Limiting to two lines
                                overflow: TextOverflow
                                    .ellipsis, // Truncate text with ellipsis if it overflows
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '\$${successState.product[index].price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),

                              // CommonButton(
                              //   title: '',
                              //   onClick: () async {
                              //     var cart = CartItem(
                              //         title: successstate.product[index].title,
                              //         description: successstate.product[index].description,
                              //         price: successstate.product[index].price,
                              //         count: 1);
                              //     await _cartService.addTodo(cart);
                              //
                              //     // Navigator.pushNamed(context, '/home');
                              //   },
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            // Return a placeholder widget or handle the non-PostSuccessfulState case
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ), // Placeholder text
            );
          }
        },
      ),
    );
  }
}
