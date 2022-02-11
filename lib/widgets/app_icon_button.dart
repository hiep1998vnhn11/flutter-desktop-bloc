import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    Key? key,
    required this.icon,
    required this.active,
    this.onPress,
  }) : super(key: key);

  final IconData icon;
  final bool active;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Stack(
        children: [
          Positioned(
            child: Icon(
              icon,
              color: active ? Theme.of(context).colorScheme.secondary : null,
            ),
            bottom: active ? 2 : 0,
          ),
          Positioned(
            bottom: 0,
            left: 10,
            child: Container(
              height: active ? 5 : 0,
              width: active ? 5 : 0,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
      onPressed: onPress,
    );
  }
}
