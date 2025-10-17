import 'package:app_movie/core/config/env.config.dart';
import 'package:app_movie/core/utils/navigation_service.dart';
import 'package:app_movie/features/movie/presentation/cubit/movies_cubit.dart';
import 'package:app_movie/features/movie/presentation/pages/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await EnvConfig.init();
  await di.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesCubit>(
          create: (_) => di.sl<MoviesCubit>()..loadMovies(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData.dark(),
        home: const MoviesPage(),
      ),
    );
  }
}
