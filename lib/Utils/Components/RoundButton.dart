import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton(
      {required this.title,
        this.loading = false,
        required this.onPress,
        super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
          onTap: onPress,
          child: Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
                color: Color(0xff7AB2D3),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
                child:loading ? const CircularProgressIndicator(color: Colors.white,): Text(
                  title,
                  style: const TextStyle(fontSize: 25),
                )),
          )),
    );
  }
}
