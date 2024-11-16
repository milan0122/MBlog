import 'package:flutter/material.dart';
import 'package:mblog/Utils/Route/RouteName.dart';
import 'package:mblog/view/navigator_screen/Home_View.dart';
import 'package:mblog/view/navigator_screen/add_blog.dart';
import 'package:mblog/view/navigator_screen/explore.dart';
import 'package:mblog/view/navigator_screen/favourite.dart';
import 'package:mblog/view/navigator_screen/users_details.dart';
class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeView(),
    Explore(),
    Favourite(),
    UserDetails(),

  ];
    final pageStorageBucket  = PageStorageBucket();
    Widget currentScreen = HomeView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: pageStorageBucket,
          child: currentScreen),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, RouteName.addBlog);
      },
      child: Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white38,
        shape:  CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                      onPressed: (){
                   setState(() {
                     currentScreen=HomeView();
                     currentTab=0;
                   });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home,
                      color: currentTab == 0 ? Colors.blue : Colors.grey,
                      ),
                      Text("Home",
                      style: TextStyle(color: currentTab == 0 ? Colors.blue : Colors.grey),)
                    ],
                  ),),
                  const SizedBox(width: 20,),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen=Explore();
                        currentTab=1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.explore_outlined,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text("Explore",
                          style: TextStyle(color: currentTab == 1 ? Colors.blue : Colors.grey),)
                      ],
                    ),),
                  const SizedBox(width: 50,),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen=Favourite();
                        currentTab=2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_outlined,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text("Favourite",
                          style: TextStyle(color: currentTab == 2 ? Colors.blue : Colors.grey),)
                      ],
                    ),),
                  const SizedBox(width: 20,),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen=UserDetails();
                        currentTab=3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text("profile",
                          style: TextStyle(color: currentTab == 3 ? Colors.blue : Colors.grey),)
                      ],
                    ),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
