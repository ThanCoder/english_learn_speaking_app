import 'package:english_learn_speaking/app/blocs/post_item_list_cubit.dart';
import 'package:english_learn_speaking/app/blocs/post_list_cubit.dart';
import 'package:english_learn_speaking/core/services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:english_learn_speaking/app/ui/home/home_screen.dart';
import 'package:english_learn_speaking/more_libs/setting/core/theme_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => DBServices())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PostListCubit(context.read<DBServices>())..init(),
          ),
          BlocProvider(
            create: (context) =>
                PostItemListCubit(context.read<DBServices>())..init(),
          ),
        ],
        child: ThemeListener(
          builder: (context, themeMode) => MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
