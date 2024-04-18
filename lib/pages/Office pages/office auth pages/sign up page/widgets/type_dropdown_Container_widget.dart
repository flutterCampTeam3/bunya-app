import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../../helper/colors.dart';

class TypeDropDownWidget extends StatefulWidget {
  const TypeDropDownWidget({
    super.key,
  });

  @override
  State<TypeDropDownWidget> createState() => _TypeDropDownWidgetState();
}

class _TypeDropDownWidgetState extends State<TypeDropDownWidget> {
  String dropDownValue = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: context.getWidth(),
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: freewhiteBrown,
          border: Border.all(color: brown)
          
        ),
        child: Row(
          children: [
             Text("  مجال الشركة :",style: TextStyle(color: blackColor,fontWeight: FontWeight.w400),),
             const SizedBox(width: 20),
             Text(dropDownValue),
             const Spacer(),
           
            DropdownButton<String>(
              menuMaxHeight: 160,
              borderRadius: BorderRadius.circular(20),
              underline: const Text(""),
             
              onChanged: (value) {
                setState(() {
                  dropDownValue = value!;
                });
              },
              items: ['ادوات البناء', 'مكتب مقاولات', 'التصميم الداخلي', 'الكهرباء',].map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
