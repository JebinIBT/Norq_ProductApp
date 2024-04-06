part of 'post_bloc.dart';

@immutable
sealed class PostState {}
 abstract class PostsActionState extends PostState{

 }

final class PostInitial extends PostState {}

class PostSuccessfulState extends PostState{
  final List<ProductModel> product;

  PostSuccessfulState({required this.product});
}
