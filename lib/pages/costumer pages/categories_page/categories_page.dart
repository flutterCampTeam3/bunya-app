import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/costumer%20pages/accounts_list/account_list.dart';
import 'package:bunya_app/pages/costumer%20pages/categories_page/widgets/category_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "استكشف في مختلف\n المجالات",
                    style: TextStyle(
                      fontSize: 24,
                      shadows: [
                        Shadow(
                          color: blackColor,
                          // offset: Offset(0.5, 0.5),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              gapH20,
              // Container(
              //   height: 370,
              //   width: double.infinity,
              //   decoration: const BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(20)),
              //       image: DecorationImage(
              //         image: AssetImage('assets/images/design_category.jpeg'),
              //         fit: BoxFit.cover,
              //       )),
              //   child: GlassContainer(
              //     width: double.infinity,
              //     height: 150,
              //     blur: 7,
              //     color: Colors.black.withOpacity(0.2),
              //     borderRadius: BorderRadius.zero,
              //     shadowColor: Colors.black.withOpacity(0.24),
              //   ),
              // )

              CategoryWidget(
                path: 'assets/images/design_category.jpeg',
                name: "التصميم الداخلي",
                onTap: () {
                  context.pushTo(view: ConstraintAccountList(type: "التصميم الداخلي",));
                },
              ),
              gapH20,
              CategoryWidget(
                path: 'assets/images/electric_category.jpeg',
                name: "الكهرباء",
                onTap: () {
                  context.pushTo(view: ConstraintAccountList(type: 'الكهرباء',));
                },
              ),
              gapH20,
              CategoryWidget(
                path: 'assets/images/moqawlat_category.jpeg',
                name: "مكاتب المقاولات",
                onTap: () {
                  context.pushTo(view: ConstraintAccountList(type: "مكاتب المقاولات",));
                },
              ),
              gapH20,
              CategoryWidget(
                path: 'assets/images/benaa_category.png',
                name: "ادوات البناء ",
                onTap: () {
                  context.pushTo(view: ConstraintAccountList(type: 'ادوات البناء',));
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
