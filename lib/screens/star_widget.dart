import 'package:flutter/material.dart';
import '../entities/star.dart';

class Star {
  final String name;
  final List<String> profileImages;
  int currentImageIndex;
  final String status;
  final String messagingCost;
  final String callCost;
  final String videoCallCost;
  final int starRating;
  final int ratingCount;

  Star({
    required this.name,
    required this.profileImages,
    this.currentImageIndex = 0,
    required this.status,
    required this.messagingCost,
    required this.callCost,
    required this.videoCallCost,
    required this.starRating,
    required this.ratingCount,
  });

  Widget buildStarCard(BuildContext context) {
    return StarCard(
      star: this,
    );
  }
}