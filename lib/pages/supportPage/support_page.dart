import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "    مرحبًا بك!   يُسرنا أن تبلغنا عن أي مشكلة، وسنكون سعداء بحلها لك.",
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(height: 20.0),
                // Text(
                //   'يرجى كتابة رسالتك هنا :',
                //   style: TextStyle(fontSize: 18.0),
                // ),
                SizedBox(height: 10.0),
                // GestureDetector(
                //   onTap: () {
                //     // Implement your email functionality here
                //   },
                //   child: Text(
                //     'support@example.com',
                //     style: TextStyle(
                //       fontSize: 18.0,
                //       color: Colors.blue,
                //       decoration: TextDecoration.underline,
                //     ),
                //   ),
                // ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'اكتب رسالتك هنا  ',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  // Add a controller if you want to capture the input
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement functionality to send support request
                  },
                  child: Text('ارسال'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
