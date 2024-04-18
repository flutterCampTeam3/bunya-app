import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 
    AppBar(
      
       title: Row(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 65,
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined),
          iconSize: 30,
        ),
        Expanded(
          child: Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: const Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "البحث",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isCollapsed: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
          iconSize: 30,
        ),
      ],
       )
    );
  }
}
