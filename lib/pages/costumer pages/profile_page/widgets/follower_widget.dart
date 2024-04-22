import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:flutter/material.dart';

class FollowresRow extends StatelessWidget {
  FollowresRow({super.key, required this.path, required this.name});
  final OfficesModel  path;
  final OfficesModel  name;
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
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: blackColor,
                    width: 1,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    path.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              gapWe20,
              Text(
                name.name,
                style: TextStyle(color: blackColor),
              ),
              const Spacer(),
              const Icon(Icons.more_vert_rounded)
            ],
          )),
    );
  }
}
