import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final double? width;
  final VoidCallback onPress;
  const RoundButton(
      {required this.title,
        this.loading = false,
        required this.onPress,
        super.key,
        this.width
      });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
          onTap: onPress,
          child: Container(
            height: 50,
            width:width ?? 300  ,
            decoration: BoxDecoration(
                color: const Color(0xff2086D5),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child:loading ? const CircularProgressIndicator(color: Colors.white,): Text(
                  title,
                  style: const TextStyle(fontSize: 25,color: Colors.white),
                )),
          )),
    );
  }
}
