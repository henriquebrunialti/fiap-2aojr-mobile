import 'package:flutter/material.dart';

class FavoriteMenuItem extends StatelessWidget {
  const FavoriteMenuItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.route});

  final String title;
  final String subtitle;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.remove_red_eye),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
