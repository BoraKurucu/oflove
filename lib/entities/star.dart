import 'package:flutter/material.dart';
import '../database/database_users.dart';

class Star {
  final String name;
  final List<dynamic> profileImages;
  int currentImageIndex;
  final String status;
  final String messagingCost;
  final String callCost;
  final String videoCallCost;
  final int starRating;
  final int ratingCount;
  final String attraction;
  final String gender;
  final int age;

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
    required this.attraction,
    required this.gender,
    required this.age,
  });

  Widget buildStarCard(BuildContext context) {
    return StarCard(
      star: this,
    );
  }
}

class StarCard extends StatefulWidget {
  final Star star;

  const StarCard({
    required this.star,
    Key? key,
  }) : super(key: key);

  @override
  _StarCardState createState() => _StarCardState();
}

class _StarCardState extends State<StarCard> {
  void _nextImage() {
    setState(() {
      widget.star.currentImageIndex = (widget.star.currentImageIndex + 1) %
          widget.star.profileImages.length;
    });
  }

  void _previousImage() {
    setState(() {
      widget.star.currentImageIndex = (widget.star.currentImageIndex - 1) %
          widget.star.profileImages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: _nextImage,
                child: Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        widget
                            .star.profileImages[widget.star.currentImageIndex],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16.0,
                bottom: 16.0,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                  onPressed: _nextImage,
                ),
              ),
              Positioned(
                left: 16.0,
                bottom: 16.0,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                  onPressed: _previousImage,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            widget.star.name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              _buildStarRating(),
              SizedBox(width: 4.0),
              Text(
                '(${widget.star.ratingCount} Reviews)',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          _buildStatusIndicator(widget.star.status),
          SizedBox(height: 12.0),
          _buildCostRow(Icons.message_rounded, widget.star.messagingCost),
          SizedBox(height: 8.0),
          _buildCostRow(Icons.call_rounded, widget.star.callCost),
          SizedBox(height: 8.0),
          _buildCostRow(Icons.video_call_rounded, widget.star.videoCallCost),
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
            color: Colors.blue,
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
          Icons.star_rounded,
          color: Colors.yellow,
          size: 24.0,
        ),
        SizedBox(width: 4.0),
        Text(
          widget.star.starRating.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}

class StarData {
  List<Map<String, dynamic>> users = [];
  //static List<Star> starsList = [];

  Future<List<Star>> getData() async {
    List<Star> starsList = [];
    users = await DatabaseUser().getUsers();
    //deneme amaçlı print sonra sil
    print(users[0]['name']);
      // users.forEach((user) {
      // print(user);
      // });
    for (int i = 0; i < users.length; i++)
    {
        starsList.add(Star(
        name: users[i]['name'],
        profileImages: users[i]['profileImages'],
        status: users[i]['status'],
        messagingCost: users[i]['messagingCost'],
        callCost: users[i]['callCost'],
        videoCallCost: users[i]['videoCallCost'],
        starRating: users[i]['starRating'],
        ratingCount: users[i]['ratingCount'],
        attraction: users[i]['attraction'],
        gender: users[i]['gender'],
        age: users[i]['age'],));
    }

      return starsList;

  }

}

