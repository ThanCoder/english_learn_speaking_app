import 'package:english_learn_speaking/app/blocs/post_list_cubit.dart';
import 'package:english_learn_speaking/app/ui/forms/post_form.dart';
import 'package:english_learn_speaking/app/ui/post_item/post_item_home_screen.dart';
import 'package:english_learn_speaking/core/extensions/context_extensions.dart';
import 'package:english_learn_speaking/core/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:english_learn_speaking/more_libs/setting/setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Setting.instance.appName),
        actions: [
          IconButton(onPressed: _showMenu, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: BlocBuilder<PostListCubit, PostListCubitState>(
        builder: (context, state) {
          return _list(state);
        },
      ),
    );
  }

  Widget _list(PostListCubitState state) {
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

  Widget _item(Post post) {
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: () => _goItemScreen(post),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                post.desc.replaceAll('\n', ''),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goItemScreen(Post post) {
    context.goRoute(builder: (context) => PostItemHomeScreen(post: post));
  }

  void _showMenu() {
    showTMenuBottomSheet(
      context,
      children: [
        ListTile(
          leading: Icon(Icons.add),
          title: Text('New Post'),
          onTap: () {
            context.closeNavigator();
            _newPostName();
          },
        ),
      ],
    );
  }

  void _newPostName() {
    context.goRoute(
      builder: (context) => PostForm(
        post: Post(title: 'Untitled', date: DateTime.now()),
        onUpdated: (updated) async {
          await context.read<PostListCubit>().add(updated);
          if (!context.mounted) return;
          showTSnackBar(context, '`${updated.title}` Created');
        },
      ),
    );
  }
}
