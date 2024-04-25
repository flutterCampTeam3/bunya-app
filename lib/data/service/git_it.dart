// import 'package:get_storage/get_storage.dart';

// class AppearanceService {
//   String currentTheme = 'Light';
//   final box = GetStorage();

//   void getTheme() {
//     if (box.read('theme') == null) {
//       box.write('theme', currentTheme);
//     } else {
//       currentTheme = box.read('theme');
//     }
//   }

//   void changeTheme() {
//     if (currentTheme == 'Dark') {
//       box.write('theme', 'Light');
//     } else {
//       box.write('theme', 'Dark');
//     }
//   }
// }
