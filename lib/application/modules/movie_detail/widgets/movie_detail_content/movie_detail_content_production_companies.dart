import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:flutter/material.dart';

class MovieDetailContentProductionCompanies extends StatelessWidget {

   final MovieDetailModel? movie;

  const MovieDetailContentProductionCompanies({ super.key, required this.movie });

   @override
   Widget build(BuildContext context) {
       return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 5),
        child: RichText(
          text: TextSpan(
            text: 'Companhia(s) produtora(s): ',
            style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black
            ),
            children: [
              TextSpan(
            text: movie?.productionCompanies.join(', ')??'',
            style: TextStyle(
              fontWeight: FontWeight.normal, color: Colors.black
            ),),
            ]
          )
        ),
       );
  }
}