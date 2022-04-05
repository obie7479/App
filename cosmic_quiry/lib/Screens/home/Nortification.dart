
import 'package:flutter/material.dart';
class Nortification extends StatefulWidget {
  const Nortification({ Key? key }) : super(key: key);

  @override
  State<Nortification> createState() => _NortificationState();
}

class _NortificationState extends State<Nortification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nortification"),
        
      ),
      body: Center(
        child: Text("Nortification"),
      ),
    );
  }
}