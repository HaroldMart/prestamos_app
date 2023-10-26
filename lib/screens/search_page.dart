import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text('Proximamente',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(88, 89, 89, 89),
            fontSize: 25,
            fontWeight: FontWeight.w600,
            height: 0,
          )
        ),
      ),
    );
  }
}