import 'package:english_learn_speaking/app/blocs/post_item_list_cubit.dart';
import 'package:english_learn_speaking/app/blocs/post_list_cubit.dart';
import 'package:english_learn_speaking/app/ui/forms/post_form.dart';
import 'package:english_learn_speaking/core/extensions/context_extensions.dart';
import 'package:english_learn_speaking/core/models/post.dart';
import 'package:english_learn_speaking/core/models/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_widgets/t_widgets.dart';

class PostItemHomeScreen extends StatefulWidget {
  final Post post;
  const PostItemHomeScreen({super.key, required this.post});

  @override
  State<PostItemHomeScreen> createState() => _PostItemHomeScreenState();
}

class _PostItemHomeScreenState extends State<PostItemHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
        actions: [
          IconButton(onPressed: _showMenu, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: BlocBuilder<PostItemListCubit, PostItemListCubitState>(
        builder: (context, state) {
          return _list(state);
        },
      ),
    );
  }

  Widget _list(PostItemListCubitState state) {
    return CustomScrollView(
      slivers: [
        if (state.isLoading)
          SliverFillRemaining(child: Center(child: TLoaderRandom()))
        else if (state.list.isEmpty)
          SliverFillRemaining(child: Center(child: Text('List Is Empty'))),
        if (state.errorMessage.isNotEmpty)
          SliverFillRemaining(
            child: Center(child: Text('Error: ${state.errorMessage}')),
          ),
        SliverList.builder(
          itemCount: state.list.length,
          itemBuilder: (context, index) => _item(state.list[index]),
        ),
      ],
    );
  }

  Widget _item(PostItem item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 3,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              item.desc.replaceAll('\n', ''),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _showMenu() {
    showTMenuBottomSheet(
      context,
      children: [
        ListTile(
          leading: Icon(Icons.add),
          title: Text('New Post Item'),
          onTap: () {
            context.closeNavigator();
            _newPostName();
          },
        ),
      ],
    );
  }

  void _newPostName() {
    // context.goRoute(
    //   builder: (context) => PostForm(
    //     post: Post(title: 'Untitled', date: DateTime.now()),
    //     onUpdated: (updated) async {
    //       await context.read<PostItemListCubit>().add(updated);
    //       if (!context.mounted) return;
    //       showTSnackBar(context, '`${updated.title}` Created');
    //     },
    //   ),
    // );
  }
}
