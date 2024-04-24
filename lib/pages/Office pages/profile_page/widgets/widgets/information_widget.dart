import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

class InformationWidgetOffice extends StatelessWidget {
  InformationWidgetOffice({super.key, required this.widget});

  Widget widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(10.0), child: widget),
    );
  }
}
