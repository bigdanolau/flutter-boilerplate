import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String path;
  final String title;
  final String subheading;

  const Labels({
    required this.path,
    required this.title,
    required this.subheading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(this.title,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(this.subheading,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushNamed(context, this.path);
            },
          )
        ],
      ),
    );
  }
}
