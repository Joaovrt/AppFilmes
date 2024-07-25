import 'package:app_filmes/application/modules/movie_detail/widgets/movie_detail_content/movie_cast.dart';
import 'package:app_filmes/application/ui/theme_extensions.dart';
import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailContentMainCast extends StatelessWidget {
  final MovieDetailModel? movie;
  final showPanel = false.obs;

  MovieDetailContentMainCast({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: context.themeGrey,
        ),
        Obx(() {
          return ExpansionPanelList(
            elevation: 0,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (panelIndex, isExpanded) {
              showPanel.toggle();
            },
            children: [
              ExpansionPanel(
                  isExpanded: showPanel.value,
                  canTapOnHeader: false,
                  backgroundColor: Colors.white,
                  headerBuilder: (context, isExpanded) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Elenco',
                            style: TextStyle(fontSize: 16),
                          )),
                    );
                  },
                  body: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          movie?.cast.map((c) => MovieCast(cast: c)).toList() ??
                              [],
                    ),
                  ))
            ],
          );
        })
      ],
    );
  }
}
