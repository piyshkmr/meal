import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.name,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  final String name;
  final IconData icon;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 44.0,
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
