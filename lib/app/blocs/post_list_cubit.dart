import 'package:english_learn_speaking/core/models/post.dart';
import 'package:english_learn_speaking/core/services/db_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListCubit extends Cubit<PostListCubitState> {
  final DBServices dbServices;
  PostListCubit(this.dbServices) : super(PostListCubitState.create());

  Future<void> init() async {
    try {
      await dbServices.init();

      emit(state.copyWith(errorMessage: '', isLoading: true, list: []));
      final list = await dbServices.getAllPost();

      emit(state.copyWith(isLoading: false, list: list));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> add(Post post) async {
    try {
      await dbServices.addPost(post);

      final list = state.list;
      list.insert(0, post);

      emit(state.copyWith(isLoading: false, list: list));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}

class PostListCubitState {
  final String errorMessage;
  final bool isLoading;
  final List<Post> list;

  const PostListCubitState({
    required this.errorMessage,
    required this.isLoading,
    required this.list,
  });

  factory PostListCubitState.create({bool isLoading = false}) {
    return PostListCubitState(errorMessage: '', isLoading: isLoading, list: []);
  }
  PostListCubitState copyWith({
    String? errorMessage,
    bool? isLoading,
    List<Post>? list,
  }) {
    return PostListCubitState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      list: list ?? this.list,
    );
  }
}
