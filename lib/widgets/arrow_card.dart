import 'package:flutter/material.dart';

class ArrowCard extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  const ArrowCard({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: IconButton(
          icon: Icon(
            icon,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
