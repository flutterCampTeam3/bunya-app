
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/sign%20up%20page/bloc/sign_up_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
         Padding(
        padding: const EdgeInsets.all(8.0),
         child: Text("صورة الحساب",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 19),),
          ),
        Stack(
          children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
                                     height: 130,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 224, 220, 220), // لون خلفية الحاوية
                                   border: Border.all(
                                   color:whiteBrown, // لون الحدود
                                    width: 1, // عرض الحدود
                                   ),
                                  ),
                                     ),
           ),
        
            Positioned(
              top: 30,
              left: MediaQuery.of(context).size.width / 2 - 37,
              child: Container(
                height: 74,
                width: 74,
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state is ShowImageState) {
                      return CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              FileImage(state.PickedImage),
                              
                              
                              );
                    }
                    return CircleAvatar(
                      radius: 70,
                      backgroundColor: white,
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<SignUpBloc>(context)
                              .add(ChoosImageEvent());
                        },
                        icon: Icon(Icons.camera_alt_outlined,
                            color: darkBrown),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 110,
              left: 95,
              child: Text("اضغط على الايقونة لرفع صورة الحساب",style: TextStyle(fontWeight: FontWeight.bold,color:darkBrown),))
          ],
        ),
      ],
    );
  }
}
