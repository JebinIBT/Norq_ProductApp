import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:machinetest/application/features/productMangement/models/product_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart'as http;

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>((postInitialFetchEvent, emit) async{
      var client = http.Client();
        List<ProductModel> products =[];
      try{
         var response =await client.get(Uri.parse('https://fakestoreapi.com/products'));
         List result =jsonDecode(response.body);
         for(int i=0;i<result.length;i++){
           ProductModel product= ProductModel.fromJson(result[i]as Map<String,dynamic>);
           products.add(product);
         }
         emit(PostSuccessfulState(product:products ));
      }catch(e){
        print(e);

      }

    });
  }
}
