import 'package:flutter/material.dart';
import 'package:mblog/Utils/Components/RoundButton.dart';
import 'package:mblog/Utils/Route/RouteName.dart';
class ChoiceView extends StatefulWidget {
  const ChoiceView({super.key});

  @override
  State<ChoiceView> createState() => _ChoiceViewState();
}

class _ChoiceViewState extends State<ChoiceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Get Started",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.normal,fontSize: 20),),
                const SizedBox(height: 10,),
                const Text("Publish Your ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
                const Text("Passion in Own Way",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
                const Text("It's Free",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundButton(title: "Register",
                        width: 180,
                        onPress: (){
                      Navigator.pushNamed(context, RouteName.signUP);
                    }),
                    const SizedBox(width: 10,),
                    RoundButton(title: "Login",width: 180, onPress: (){
                      Navigator.pushNamed(context, RouteName.login);
                    }),
                     const SizedBox(height: 200,)


                  ],
                )

          ],
        ),
      ),
    );
  }
}
