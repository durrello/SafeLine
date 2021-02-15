// import 'package:flutter/material.dart';

// final header = TextStyle(
//   color: Colors.white,
//   fontSize: 20.0,
//   height: 1.5,
// );

// final subheading = TextStyle(
//   color: Colors.white,
//   fontSize: 14.0,
//   height: 1.5,
// );

// Widget getField(headerTxt, imageSrc, descTxt) {
//   return Padding(
//     padding: EdgeInsets.all(10.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           child: Text(
//             headerTxt,
//             style: header,
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: 30.0),
//             Center(
//               child: Image(
//                 image: AssetImage(imageSrc),
//                 // height: 300.0,
//                 // width: 300.0,
//               ),
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               descTxt,
//               style: subheading,
//             )
//           ],
//         ),
//       ],
//     ),
//   );
// }

// Widget getButton(_pageController) {
//   return FlatButton(
//     onPressed: () {
//       _pageController.nextPage(
//           duration: Duration(microseconds: 300), curve: Curves.easeIn);
//     },
//     child: Text(
//       'Next',
//       style: TextStyle(color: Colors.white, fontSize: 24.0),
//     ),
//   );
// }

// BoxDecoration getDecoration() {
//   return BoxDecoration(
//       gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           stops: [0.1, 0.4, 0.9],
//           colors: [Color(0xFF4d4d4d), Color(0xFFeeeceb), Color(0xFF4d4d4d)]));
// }

// Widget indicator(bool isActive) {
//   return AnimatedContainer(
//     duration: Duration(microseconds: 150),
//     margin: EdgeInsets.symmetric(horizontal: 8.0),
//     height: 8.0,
//     width: isActive ? 24.0 : 16.0,
//     decoration: BoxDecoration(
//       color: isActive ? Colors.white : Colors.black,
//       borderRadius: BorderRadius.all(Radius.circular(12)),
//     ),
//   );
// }
