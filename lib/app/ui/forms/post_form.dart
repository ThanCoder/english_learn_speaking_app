import 'package:english_learn_speaking/core/extensions/context_extensions.dart';
import 'package:english_learn_speaking/core/models/post.dart';
import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class PostForm extends StatefulWidget {
  final Post post;
  final String? title;
  final void Function(Post updated) onUpdated;
  const PostForm({
    super.key,
    this.title,
    required this.post,
    required this.onUpdated,
  });

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  @override
  void initState() {
    titleController.text = widget.post.title;
    urlController.text = widget.post.url;
    descController.text = widget.post.desc;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    urlController.dispose();
    descController.dispose();
    super.dispose();
  }

  final titleController = TextEditingController();
  final urlController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? widget.post.title)),
      body: TScrollableColumn(
        children: [
          TTextField(
            label: Text('Title'),
            maxLines: 1,
            controller: titleController,
          ),
          TTextField(
            label: Text('Page Url'),
            maxLines: 1,
            controller: urlController,
          ),
          TTextField(
            label: Text('Description'),
            maxLines: null,
            controller: descController,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSave,
        child: Icon(Icons.save_as),
      ),
    );
  }

  void _onSave() {
    try {
      if (titleController.text.isEmpty) {
        throw Exception('title is requied');
      }
      context.closeNavigator();

      widget.onUpdated(
        widget.post.copyWith(
          title: titleController.text,
          desc: descController.text,
          url: urlController.text,
        ),
      );
    } catch (e) {
      showTMessageDialogError(context, e.toString());
    }
  }
}
