import 'package:flutter/material.dart';
import 'app_constant.dart';
import 'movie_model.dart';
import 'movie_detail_page.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;
  final double imageHeight;
  final bool isPotrait;

  MovieWidget(
      {required this.movie, this.imageHeight = 150.0, this.isPotrait = false});

  @override
  Widget build(BuildContext context) {
    double aspectRatio = isPotrait ? 9 / 16 : 16 / 9;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(movie: movie),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            '${AppConstant.imageUrlW500}${movie.posterPath}',
            height: imageHeight,
            width: imageHeight *
                aspectRatio, // Sesuaikan lebar gambar sesuai keinginan Anda
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
