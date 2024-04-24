import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:flutter/material.dart';

class AccountsHomeWidget extends StatelessWidget {
  const AccountsHomeWidget(
      {super.key,
      required this.description,
      required this.path,
      required this.title});

  final OfficesModel path;
  final OfficesModel title;
  final OfficesModel description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: ,
        width: context.getWidth() * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: darkGreyColor.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                  child: Image.network(path.image, fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                    return Image.asset("assets/images/noimage.png");
                  }),
                ),
              ),
              gapWe10,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.name,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: context.getWidth()*0.4,
                    child: Text(
                      description.disc ?? " ",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color:  Theme.of(context).colorScheme.secondary,fontSize: 15),
                      
                    ),
                  ),
                  // Text(
                  //   description.disc,
                  //   style: TextStyle(
                  //       fontSize: 15,
                  //       color: Theme.of(context).colorScheme.secondary),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
