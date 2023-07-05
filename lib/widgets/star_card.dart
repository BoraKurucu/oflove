import 'package:flutter/material.dart';
import 'package:oflove/entities/star.dart';

class StarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star List'),
      ),
      body: ListView.builder(
        itemCount: StarData.stars.length,
        itemBuilder: (context, index) {
          Star star = StarData.stars[index];
          return StarCard(star: star);
        },
      ),
    );
  }
}

class StarCard extends StatelessWidget {
  final Star star;

  const StarCard({required this.star});

  @override
  Widget build(BuildContext context) {
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
                image: AssetImage(star.profileImage),
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
                      star.name,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildStarRating(star.starRating),
                  ],
                ),
                SizedBox(height: 12.0),
                _buildStatusIndicator(star.status),
                SizedBox(height: 12.0),
                _buildCostRow(Icons.message, star.messagingCost),
                SizedBox(height: 8.0),
                _buildCostRow(Icons.call, star.callCost),
                SizedBox(height: 8.0),
                _buildCostRow(Icons.video_call, star.videoCallCost),
                SizedBox(height: 4.0),
                Text(
                  '(${star.ratingCount} Ratings)',
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

  Widget _buildStarRating(int rating) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 24.0,
        ),
        SizedBox(width: 4.0),
        Text(
          rating.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
