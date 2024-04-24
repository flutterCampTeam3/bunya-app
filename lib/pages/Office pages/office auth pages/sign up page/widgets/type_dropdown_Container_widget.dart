import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/sign%20up%20page/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    String dropDownValue = bloc.type;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: context.getWidth(),
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
            color: freewhiteBrown, border: Border.all(color: brown)),
        child: Row(
          children: [
            Text(
              "  مجال الشركة :",
              style: TextStyle(color: blackColor, fontWeight: FontWeight.w400),
            ),
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
                  bloc.type = value;
                });
              },
              items: [
                'ادوات البناء',
                'مكتب مقاولات',
                'التصميم الداخلي',
                'الكهرباء',
              ].map((type) {
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
