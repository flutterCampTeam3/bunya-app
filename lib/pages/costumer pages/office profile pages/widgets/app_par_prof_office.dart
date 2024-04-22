import 'package:flutter/material.dart';

class AppBarOfficeProfileWidget extends StatelessWidget {
  const AppBarOfficeProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ],
        ));
  }
}
