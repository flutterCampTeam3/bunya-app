import 'package:flutter/material.dart';

class AppBarAccoutWidget extends StatelessWidget {
   AppBarAccoutWidget({
    super.key, required this.controllerSearch,
    required this.onSubmitted
  });
  final controllerSearch ;
  void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            // Image.asset(
            //   'assets/images/logo.png',
            //   width: 65,
            // ),
            // const Spacer(),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.notifications_none_outlined),
            //   iconSize: 30,
            // ),
            Expanded(
              child: Container(
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child:  Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: onSubmitted,
                        decoration: InputDecoration(
                          hintText: "البحث",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isCollapsed: true,
                          
                        ),
                        controller: controllerSearch,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     Scaffold.of(context).openDrawer();
            //   },
            //   icon: const Icon(Icons.menu),
            //   iconSize: 30,
            // ),
          ],
        ));
  }
}
