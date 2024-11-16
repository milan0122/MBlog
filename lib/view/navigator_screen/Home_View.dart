import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mblog/Utils/Route/RouteName.dart';
import 'package:mblog/Utils/utils.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final searchController= TextEditingController();
  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.ref().child('Post');
  String search = "";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async{
      SystemNavigator.pop();
      return true;

      },
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('MBLOG',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  _auth.signOut().then((value) {
                    Navigator.pushNamed(context, RouteName.medScreen);
                  }).onError((error, StackTrace) {
                    Utils.toastMessage(error.toString());
                  });
                },
                icon: const Icon(Icons.login_rounded)),
            SizedBox(width: 25,)
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search..',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          )
                      ),
                      onChanged: (String value) {
                        setState(() {
                        });

                      },
                    ),),),
                  Expanded(
                    flex: 10,
                      child: FirebaseAnimatedList(
                          query: dbRef.child('Post List'),
                          itemBuilder: (BuildContext context,DataSnapshot snapshot, Animation<double>animation,int index){
                            String tempTitle = snapshot.child('PTitle').value.toString();
                            if(searchController.text.isEmpty){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.circular(12),
                                      child: FadeInImage.assetNetwork(
                                          placeholder: 'assets/blog_logo.jpeg',
                                          image: snapshot.child('PImage').value.toString(),
                                          height: 200,
                                          width:200,
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 28.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.child('PTitle').value.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                                        Text(snapshot.child('PTitle').value.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                                        Text(snapshot.child('pDescription').value.toString(),style: TextStyle(fontWeight: FontWeight.normal,fontSize: 24),),
                                      ],
                                    ),
                                  ))

                                ],
                              );
                            }
                            else if(tempTitle.toLowerCase().contains(searchController.text.toLowerCase())){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.circular(12),
                                      child: FadeInImage.assetNetwork(
                                          placeholder: 'assets/blog_logo.jpeg',
                                          image: snapshot.child('PImage').value.toString(),
                                          height: 200,
                                          width:200,
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 28.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.child('PTitle').value.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                                        Text(snapshot.child('pDescription').value.toString(),style: TextStyle(fontWeight: FontWeight.normal,fontSize: 24),),
                                      ],
                                    ),
                                  ))

                                ],
                              );

                            }
                            else{
                              return Container();
                            }

                  }
                      ))
                ],
              ),
            ),

          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){
          Navigator.pushNamed(context,RouteName.addBlog);
        },
        child: const Icon(Icons.add),),

       bottomNavigationBar: BottomNavigationBar(
         selectedItemColor:  Color(0xff2086D5),
           unselectedItemColor: Colors.black,
           items:const [
         BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
         BottomNavigationBarItem(icon: Icon(Icons.explore_outlined,),label: 'explore'),
         BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: 'Favourite'),
         BottomNavigationBarItem(icon: Icon(Icons.person,),label: 'User')
       ]),



      ),
    );
  }
}
