import 'package:flutter/material.dart';
import 'package:qoruz/widgets/common_app_bar.dart';

class PlaceHolderScreen extends StatelessWidget {
  final String title;
  const PlaceHolderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: title,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_open_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text("$title, Feature is Coming Soon"),
      ),
    );
  }
}
