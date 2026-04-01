import 'package:english_learn_speaking/core/models/post.dart';
import 'package:english_learn_speaking/core/models/post_item.dart';
import 'package:english_learn_speaking/core/services/db_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostItemListCubit extends Cubit<PostItemListCubitState> {
  final DBServices dbServices;
  PostItemListCubit(this.dbServices) : super(PostItemListCubitState.create());

  Future<void> init() async {
    try {
      emit(state.copyWith(errorMessage: '', isLoading: true, list: []));
      final list = await dbServices.getAllPostItem();

      emit(state.copyWith(isLoading: false, list: list));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> add(PostItem item) async {
    try {
      await dbServices.addPostItem(item);

      final list = state.list;
      // list.insert(0, post);

      emit(state.copyWith(isLoading: false, list: list));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}

class PostItemListCubitState {
  final String errorMessage;
  final bool isLoading;
  final List<PostItem> list;

  const PostItemListCubitState({
    required this.errorMessage,
    required this.isLoading,
    required this.list,
  });

  factory PostItemListCubitState.create({bool isLoading = false}) {
    return PostItemListCubitState(
      errorMessage: '',
      isLoading: isLoading,
      list: [],
    );
  }
  PostItemListCubitState copyWith({
    String? errorMessage,
    bool? isLoading,
    List<PostItem>? list,
  }) {
    return PostItemListCubitState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      list: list ?? this.list,
    );
  }
}
