import 'package:flutter/material.dart';
import '../entities/star.dart';

class StarListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: StarData.stars.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: StarData.stars[index].buildStarCard(context),
        );
      },
    );
  }
}
