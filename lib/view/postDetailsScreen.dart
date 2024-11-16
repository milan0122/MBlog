import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.ref().child('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body:Column(
        children: [
          FirebaseAnimatedList(
              query:dbRef.child('Post List') ,
              itemBuilder: (BuildContext context,DataSnapshot snapshots,Animation<double>animation,int index){
                String dateString = snapshots.child('PTime').value.toString();
                DateTime parseDate = DateFormat('dd-MM-yyyy').parse(dateString);
                String formattedDate = DateFormat('dd MMM yyyy').format(parseDate);
                return Column(
                  children: [
                    Text(formattedDate),
                    Text(snapshots.child('Ptitle').value.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.normal))
                    
                  ],
                );
              })
        ],
      )

    );
  }
}
