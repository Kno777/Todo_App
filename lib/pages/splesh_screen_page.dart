import 'package:flutter/material.dart';
import 'dart:async';

import 'package:todo_app/pages/todo_home_page.dart';

class SpleshScreenPage extends StatefulWidget {
  const SpleshScreenPage({Key? key}) : super(key: key);

  @override
  State<SpleshScreenPage> createState() => _SpleshScreenPageState();
}

class _SpleshScreenPageState extends State<SpleshScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  TodoHomePage(),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      child: Image.asset(
        'assets/images/1.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
