import 'package:app_movie/features/movie/presentation/cubit/movies_cubit.dart';
import 'package:app_movie/features/movie/presentation/widgets/error_view.dart';
import 'package:app_movie/features/movie/presentation/widgets/loading_view.dart';
import 'package:app_movie/features/movie/presentation/widgets/movie_filterbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/movies_section_widget.dart';
import '../widgets/movies_grid_widget.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage>
    with AutomaticKeepAliveClientMixin {
  String _selectedFilter = 'Todos';

  @override
  bool get wantKeepAlive => true;

  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
    print('Filtro seleccionado: $filter');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return const LoadingView();
            } else if (state is MoviesError) {
              return ErrorView(
                message: state.message,
                onRetry: () => context.read<MoviesCubit>().loadMovies(),
              );
            } else if (state is MoviesLoaded) {
              final movies = state.movies;
              final upcoming = movies.where((m) => m.isUpcoming).toList();
              final trending = movies.where((m) => m.isTrending).toList();

              return CustomScrollView(
                key: const PageStorageKey('moviesScroll'),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Próximos estrenos",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          MoviesSectionWidget(movies: upcoming),
                          const SizedBox(height: 16),
                          const Text(
                            "Tendencia",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          MoviesSectionWidget(movies: trending),
                          const SizedBox(height: 16),
                          const Text(
                            "Recomendados para ti",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          MovieFilterBar(
                            onFilterSelected: _onFilterSelected,
                            selectedFilter: _selectedFilter,
                          ),
                          const SizedBox(height: 8),
                          MoviesGridWidget(
                            movies: trending
                                .where((movie) =>
                                    _selectedFilter == 'Todos' || true)
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
