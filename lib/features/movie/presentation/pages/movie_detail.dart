import 'package:app_movie/core/utils/navigation_service.dart';
import 'package:app_movie/features/movie/data/models/detail_movie.dart';
import 'package:app_movie/features/movie/presentation/cubit/movies_detail_cubit.dart';
import 'package:app_movie/features/movie/presentation/cubit/movies_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_movie/features/movie/domain/entities/movie.dart';
import 'package:app_movie/features/movie/presentation/cubit/movies_cubit.dart';
import 'package:app_movie/features/movie/presentation/widgets/error_view.dart';
import 'package:app_movie/injection_container.dart' as di;
import 'package:cached_network_image/cached_network_image.dart'; // Añadir import

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailCubit>(
      create: (_) =>
          di.sl<MovieDetailCubit>()..loadMovieDetail(widget.movie.id),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.red),
              );
            } else if (state is MovieDetailError) {
              return ErrorView(
                message: state.message,
                onRetry: () => context
                    .read<MovieDetailCubit>()
                    .loadMovieDetail(widget.movie.id),
              );
            } else if (state is MovieDetailLoaded) {
              return _buildMovieDetail(
                  context, widget.movie, state.movieDetail);
            }

            return _buildMovieDetail(context, widget.movie, null);
          },
        ),
      ),
    );
  }

  Widget _buildMovieDetail(
      BuildContext context, Movie movie, MovieDetailModel? detail) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 500,
          pinned: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => NavigationService.pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                // Imagen de fondo con CachedNetworkImage
                CachedNetworkImage(
                  imageUrl: detail?.backdropPath != null
                      ? 'https://image.tmdb.org/t/p/w780${detail!.backdropPath}'
                      : movie.posterUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[800],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.movie,
                          color: Colors.white,
                          size: 100,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Sin imagen disponible',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Gradiente
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                        Colors.black,
                      ],
                    ),
                  ),
                ),
                // Contenido superpuesto
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (detail?.tagline != null &&
                          detail!.tagline!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          detail.tagline!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      // Rating, año y duración
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'TMDb',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            detail?.releaseYear ??
                                movie.releaseDate.split('-').first,
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          if (detail?.runtime != null) ...[
                            const SizedBox(width: 16),
                            Text(
                              detail!.runtimeFormatted,
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Géneros
                      Text(
                        detail?.genresString ?? 'Cargando géneros...',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Botón Ver trailer
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implementar lógica para ver trailer
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Función de trailer próximamente'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Ver trailer'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sección Sinopsis
                const Text(
                  'SINOPSIS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  movie.overview ?? 'Sin sinopsis disponible.',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                // Información adicional (solo cuando hay detalles cargados)
                if (detail != null) ...[
                  const SizedBox(height: 24),
                  const Text(
                    'INFORMACIÓN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow('Duración:', detail.runtimeFormatted),
                  _buildInfoRow('Idioma:', detail.primaryLanguage),
                  _buildInfoRow('Fecha de estreno:', detail.releaseDate),
                  _buildInfoRow('Estado:', detail.status),
                  if (detail.budget != null && detail.budget! > 0)
                    _buildInfoRow(
                        'Presupuesto:', '\$${_formatMoney(detail.budget!)}'),
                  if (detail.revenue != null && detail.revenue! > 0)
                    _buildInfoRow(
                        'Recaudación:', '\$${_formatMoney(detail.revenue!)}'),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatMoney(int amount) {
    if (amount >= 1000000000) {
      return '\$${(amount / 1000000000).toStringAsFixed(1)}B';
    } else if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(1)}K';
    }
    return '\$${amount.toString()}';
  }
}
