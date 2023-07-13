import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oflove/database/database_users.dart';

class Star {
  String attraction_gender;
  String birthday;
  String callcost;
  int currentImageIndex;
  String email;
  String gender;
  String messagingcost;
  String name;
  List<dynamic> profileImages = [];
  String rating;
  String ratingcount;
  String status;
  String uid;
  String videocost;

  Star({
    required this.attraction_gender,
    required this.birthday,
    required this.callcost,
    this.currentImageIndex = 0,
    required this.email,
    required this.gender,
    required this.messagingcost,
    required this.name,
    required this.profileImages,
    required this.rating,
    required this.ratingcount,
    required this.status,
    required this.uid,
    required this.videocost,
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
    return SizedBox(
      width: double.infinity,
      height: 488,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<String?>(
                future: DatabaseUser().getImageUrl(
                    widget.star.profileImages[widget.star.currentImageIndex]),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final imageUrl = snapshot.data;
                    if (imageUrl == null) {
                      return Text('Image not found');
                    }
                    return Container(
                      height: 360.0,
                      width: 480.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
// Inside the Container that wraps the profile image
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            height: 360.0,
                            width: 480.0,
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 16.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildArrowButton(
                                  Icons.arrow_back_ios_rounded,
                                  _previousImage,
                                ),
                                SizedBox(width: 16.0),
                                _buildArrowButton(
                                  Icons.arrow_forward_ios_rounded,
                                  _nextImage,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
              Row(children: [
                SizedBox(height: 16.0),
                Text(
                  widget.star.name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 48.0),
                _buildStatusIndicator(widget.star.status),
              ]),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  _buildStarRating(),
                  SizedBox(width: 4.0),
                  Text(
                    '(${widget.star.ratingcount} Reviews)',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
              Row(children: [
                SizedBox(height: 12.0),
                _buildCostRow(Icons.message_rounded, widget.star.messagingcost),
                SizedBox(height: 8.0),
                _buildCostRow(Icons.call_rounded, widget.star.callcost),
                SizedBox(height: 8.0),
                _buildCostRow(Icons.video_call_rounded, widget.star.videocost),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.blue.withOpacity(1.0), // Shading color on click
      borderRadius: BorderRadius.circular(8.0), // Rounded corners

      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 32.0,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color indicatorColor;
    String statusText;
    switch (status) {
      case 'Online':
        indicatorColor = Colors.green;
        statusText = 'Talk Now!';
        break;
      case 'Offline':
        indicatorColor = Colors.grey;
        statusText = 'Offline';
        break;
      case 'Busy':
        indicatorColor = Colors.red;
        statusText = 'Talking Someone';
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
          style: TextStyle(fontSize: 24.0),
        ),
      ],
    );
  }

  Widget _buildCostRow(IconData icon, String cost) {
    return InkWell(
      onTap: () {
        print(widget.star.uid); // Print the ID of the star
      },
      splashColor: Colors.blue.withOpacity(0.3), // Shading color on click
      borderRadius: BorderRadius.circular(8.0), // Rounded corners
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
          size: 32.0,
        ),
        SizedBox(width: 4.0),
        Text(
          widget.star.rating.toString(),
          style: TextStyle(fontSize: 24.0),
        ),
      ],
    );
  }
}
