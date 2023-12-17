import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:triplaner/domain/entities/search_location.dart';
import 'package:triplaner/domain/entities/search_suggestion.dart';

import 'search_suggestion_tile.dart';

class SearchShimmer extends StatelessWidget {
  const SearchShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: true,
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return SearchSuggestionTile(
              searchSuggestion: SearchLocation.empty(),
              onTap:(){}
            );
          },
        ));
  }
}
