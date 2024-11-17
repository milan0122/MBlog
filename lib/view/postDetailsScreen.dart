import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart'; // To format the date

class PostDetailsScreen extends StatelessWidget {
  final String postId;

  PostDetailsScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    // Reference to the 'Post List' node in Firebase
    final dbRef = FirebaseDatabase.instance.ref("Post/Post List/$postId");

    return Scaffold(
      appBar: AppBar(
        title: Text('PostDetails'),
      ),
      body:FutureBuilder<DataSnapshot>(future: dbRef.get(), builder:(context,snapshots){
        var postData = snapshots.data!.value as Map<dynamic,dynamic>?;
        if (postData == null) {
          return Center(child: Text('Invalid post data'));
        }
        String title = postData['PTitle'] ?? 'No Title';
        String timeString = postData['PTime']??" ";
        DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(timeString);
        String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
        String description = postData['pDescription'] ?? 'No Description';
        String userName = postData['uEmail'] ?? "No email";
        String imageUrl = postData['PImage'] ?? '';


        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formattedDate),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(userName),
                   Container(
                     width: 70,
                     height: 40,
                     decoration: BoxDecoration(
                       color: Colors.blue,
                       borderRadius: BorderRadius.circular(20)
                     ),
                     child:Center(child: Text('Follow',style: TextStyle(color: Colors.white38),)),
                   )
                  ],
                ),
                Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                imageUrl.isNotEmpty
                    ? Image.network(imageUrl)
                    : Placeholder(fallbackHeight: 200),
                const SizedBox(height: 20),
                Text(description,style: TextStyle(fontWeight: FontWeight.normalgi,fontSize: 30),),


              ],
            ),
          ),
        );
      })
    );
  }
}
