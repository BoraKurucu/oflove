import 'package:flutter/material.dart';

class Star {
  final String name;
  final String profileImage;
  final String status;
  final String messagingCost;
  final String callCost;
  final String videoCallCost;
  final int starRating;
  final int ratingCount;

  const Star({
    required this.name,
    required this.profileImage,
    required this.status,
    required this.messagingCost,
    required this.callCost,
    required this.videoCallCost,
    required this.starRating,
    required this.ratingCount,
  });

  Widget buildStarCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(profileImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildStarRating(),
                  ],
                ),
                SizedBox(height: 12.0),
                _buildStatusIndicator(status),
                SizedBox(height: 12.0),
                _buildCostRow(Icons.message, messagingCost),
                SizedBox(height: 8.0),
                _buildCostRow(Icons.call, callCost),
                SizedBox(height: 8.0),
                _buildCostRow(Icons.video_call, videoCallCost),
                SizedBox(height: 4.0),
                Text(
                  '($ratingCount Ratings)',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color indicatorColor;
    String statusText;
    switch (status) {
      case 'Online':
        indicatorColor = Colors.green;
        statusText = 'Online';
        break;
      case 'Offline':
        indicatorColor = Colors.grey;
        statusText = 'Offline';
        break;
      case 'Busy':
        indicatorColor = Colors.red;
        statusText = 'Busy';
        break;
      default:
        indicatorColor = Colors.transparent;
        statusText = '';
    }
    return Row(
      children: [
        Container(
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: indicatorColor,
          ),
        ),
        SizedBox(width: 4.0),
        Text(
          statusText,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  Widget _buildCostRow(IconData icon, String cost) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24.0,
          ),
          SizedBox(width: 12.0),
          Text(
            cost,
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(width: 50.0),
        ],
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 24.0,
        ),
        SizedBox(width: 4.0),
        Text(
          starRating.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}

class StarData {
  static final List<Star> stars = [
    Star(
      name: 'Star 1',
      profileImage: 'assets/star1.png',
      status: 'Online',
      messagingCost: '\$5',
      callCost: '\$10',
      videoCallCost: '\$15',
      starRating: 3,
      ratingCount: 192,
    ),
    Star(
      name: 'Star 2',
      profileImage: 'assets/star2.png',
      status: 'Offline',
      messagingCost: '\$8',
      callCost: '\$12',
      videoCallCost: '\$18',
      starRating: 5,
      ratingCount: 1000,
    ),
    Star(
      name: 'Star 3',
      profileImage: 'assets/star3.png',
      status: 'Busy',
      messagingCost: '\$7',
      callCost: '\$11',
      videoCallCost: '\$16',
      starRating: 4,
      ratingCount: 500,
    ),
    // Add more stars as needed
  ];
}
