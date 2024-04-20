import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/signIn%20page/signin_page.dart';
import 'package:bunya_app/pages/costumer%20pages/costumer%20auth%20pages/sign%20up%20page/signup_page.dart';
import 'package:bunya_app/pages/costumer%20pages/costumer%20auth%20pages/signIn%20page/signin_customer_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingPage extends StatelessWidget {
  BoardingPage({super.key, this.isCustomer = true});
  final bool isCustomer;

  final boardController = PageController();

  // bool isLast = false;
  ValueNotifier<bool> isLast = ValueNotifier(false);
  List<SplashModel> boarding = [];
  @override
  Widget build(BuildContext context) {
    if (isCustomer) {
      boarding = [
        SplashModel(
          image: "assets/images/image1.png",
          backImage: "assets/images/introv3.png",
          body: '     ابدأ رحلتك بالعثور على كل\n ما تحتاجه لبناء منزلك  ',
        ),
        SplashModel(
          image: "assets/images/image2.png",
          backImage: "assets/images/introv4.png",
          body:
              " ابحث عن أفضل الشركات الهندسية \nوشركات المقاولات واستوديوهات التصميم الداخلي ",
        ),
        SplashModel(
          image: "assets/images/image3.png",
          backImage: "assets/images/introv2.png",
          body: " تواصل مع أفضل الشركات \nلتلبية احتياجات بناء منزلك",
        )
      ];
    } else {
      boarding = [
        SplashModel(
          image: "assets/images/image1.png",
          backImage: "assets/images/introv3.png",
          body:
              '  سجل شركتك الآن لتكون جزءًا من \nتطبيقنا الذي يوفر للعملاء فرصة \nاختيار أفضل الشركات لبناء منازلهم ',
        ),
        SplashModel(
            image: "assets/images/image2.png",
            backImage: "assets/images/introv4.png",
            body: " ابدأ بنشر أعمالك \nوخدماتك في بناء المنازل معنا"),
        SplashModel(
          image: "assets/images/image3.png",
          backImage: "assets/images/introv2.png",
          body:
              " وسّع نطاق عملك وصل إلى زبائن جدد يبحثون عن شركات موثوقة في بناء المنازل  ",
        )
      ];
    }

    Widget buildBoardingItem(SplashModel model, int length) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: context.getHeight() * 0.70,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          model.backImage,
                        ),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(model.image),
                    SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            model.body,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              // Define text style here if needed
                            ),
                            textScaleFactor: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Flexible(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 1,
                            child: SizedBox(
                                height: 95,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              if (isLast.value) {
                                                if (isCustomer) {
                                                  context.pushAndRemove(
                                                      const SigninCustomerPage());
                                                } else {
                                                  context.pushAndRemove(
                                                      const SigninPage());
                                                }
                                              } else {
                                                boardController.nextPage(
                                                  duration: const Duration(
                                                    milliseconds: 1500,
                                                  ),
                                                  curve: Curves
                                                      .fastLinearToSlowEaseIn,
                                                );
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                foregroundColor: blackColor,
                                                elevation: 0,
                                                backgroundColor: transparent,
                                                shape: const CircleBorder()),
                                            child: const Text("التالي"),
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              decoration: const BoxDecoration(),
                                              child: SmoothPageIndicator(
                                                controller: boardController,
                                                effect: ScaleEffect(
                                                    dotHeight: 7,
                                                    dotWidth: 30,
                                                    spacing: 6.0,
                                                    scale: 1,
                                                    activeDotColor: darkbrown),
                                                count: length,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (isCustomer) {
                                                context.pushAndRemove(
                                                    const SigninCustomerPage());
                                              } else {
                                                context.pushAndRemove(
                                                    const SigninPage());
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                shape: const CircleBorder(),
                                                elevation: 0,
                                                foregroundColor: blackColor,
                                                backgroundColor: transparent),
                                            child: const Text("التخطي"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollBehavior: const MaterialScrollBehavior(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      isLast.value = true;
                    } else {
                      isLast.value = false;
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index], boarding.length),
                  itemCount: boarding.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashModel {
  final String image;
  final String backImage;

  final String body;

  SplashModel({
    required this.image,
    required this.backImage,
    required this.body,
  });
}
