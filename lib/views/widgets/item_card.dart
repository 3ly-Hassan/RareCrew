import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ItemCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: ListTile(
        onTap: onTap,
        trailing: trailing,
        tileColor: const Color.fromARGB(116, 23, 197, 231),
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}
