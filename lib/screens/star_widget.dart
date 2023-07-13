import 'package:flutter/material.dart';
import '../entities/star.dart';
import 'package:oflove/database/database_users.dart';

class StarListWidget extends StatefulWidget {
  @override
  _StarListWidgetState createState() => _StarListWidgetState();
}

class _StarListWidgetState extends State<StarListWidget> {
  List<Star> starsList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Star> data = await DatabaseUser().getData();
    setState(() {
      starsList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: starsList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: starsList[index].buildStarCard(context),
        );
      },
    );
  }
}




// class StarListWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print('A');
//     List<Star> starsList = [];
//     StarData stars = new StarData();
//     starsList = await stars.getData();
//     print(starsList.length);
//     return ListView.builder(
//       itemCount: starsList.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 8.0,
//             horizontal: 16.0,
//           ),
//           child: starsList[index].buildStarCard(context),
//         );
//       },
//     );
//   }
// }
