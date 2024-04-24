import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/account_list_bloc.dart';

class AccountListWidget extends StatelessWidget {
  const AccountListWidget({
    super.key,
    required this.description,
    required this.path,
    required this.title,
    required this.onTap,
    required this.officeId,
  });

  final String path;
  final String title;
  final String description;
  final VoidCallback onTap;
  final OfficesModel officeId;
  @override
  Widget build(BuildContext context) {
   
    return BlocProvider(
      create: (context) => AccountListBloc(),
      child: Builder(builder: (context) {
         final bloc = context.read<AccountListBloc>();
        bloc.add(ShowFollowersEvent(id: officeId.officeId));
        return BlocBuilder<AccountListBloc, AccountListState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: onTap,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
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
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                path,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(color: blackColor),
                                ),
                                Text(
                                  description,
                                  style: const TextStyle(
                                      fontSize: 9, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Row(
                                  /*
                                          children: [
                                            Text('$rate '),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 20,
                                            ),
                                          ],
                                          */
                                  ),
                              const Divider(
                                  height: 18, thickness: 1, color: Colors.grey),
                              Row(
                                children: [
                                  Text('${bloc.followerNumber}',style: TextStyle(color: blackColor),),
                                  const SizedBox(width: 5),
                                   Icon(
                                    Icons.people,
                                    color: blackColor,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  gapH15
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
