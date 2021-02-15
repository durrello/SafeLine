import 'package:flutter/material.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/models/page_models.dart';
import 'package:stay_safe/src/screens/welcome/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static String id = 'onboarding_screen';
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            pages[currentIndex].img,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: FlatButton(
                  onPressed: () => Navigator.pushNamed(context, WelcomeScreen.id),
                  child: Text('Skip Tutorial',
                      style: TextStyle(color: primaryColor, fontSize: 18)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                height: size.height * .4,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        pages[currentIndex].icon,
                        color: Colors.red[500],
                        size: 40,
                      ),
                      Text(
                        pages[currentIndex].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Container(
                        width: size.width * .6,
                        child: Text(
                          pages[currentIndex].subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        width: size.width * .8,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (currentIndex < 2) currentIndex++;
                                  else if(currentIndex == 2) {
                                    Navigator.pushNamed(context, WelcomeScreen.id);
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: currentIndex == 2
                                      ? Colors.red[500]
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Container(
                                      child: Text(
                                      currentIndex == 2
                                          ? "Let's Start" 
                                          : "Next",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: currentIndex == 2
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 10,
                            width: 10,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 0
                                  ? Colors.black
                                  : Colors.grey[300],
                            ),
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 1
                                  ? Colors.black
                                  : Colors.grey[300],
                            ),
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 2
                                  ? Colors.black
                                  : Colors.grey[300],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:stay_safe/src/helpers/style.dart';
// import 'package:stay_safe/src/screens/welcome/welcome_screen.dart';

// class OnboardingScreen extends StatefulWidget {
//   static String id = 'onboarding_screen';
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final int _numPages = 3;
//   final PageController _pageController = PageController(initialPage: 0);
//   int _currentPage = 0;

//   List<Widget> _buildPageIndicator() {
//     List<Widget> list = [];
//     for (int i = 0; i < _numPages; i++) {
//       list.add(i == _currentPage ? _indicator(true) : _indicator(false));
//     }
//     return list;
//   }

//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 150),
//       margin: EdgeInsets.symmetric(horizontal: 8.0),
//       height: 8.0,
//       width: isActive ? 24.0 : 16.0,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.white : Color(0xFF7B51D3),
//         borderRadius: BorderRadius.all(Radius.circular(12)),
//       ),
//     );
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   new Future.delayed(
//   //       const Duration(seconds: 3),
//   //       () => Navigator.push(
//   //             context,
//   //             MaterialPageRoute(builder: (context) => WelcomeScreen()),
//   //           ));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               stops: [0.1, 0.4, 0.7, 0.9],
//               colors: [
//                 Color(0xFF3594DD),
//                 Color(0xFF4563DB),
//                 Color(0xFF5036D5),
//                 Color(0xFF5B16D0),
//               ],
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 40.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Container(
//                   alignment: Alignment.centerRight,
//                   child: FlatButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Skip',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 400.0,
//                   child: PageView(
//                     physics: ClampingScrollPhysics(),
//                     controller: _pageController,
//                     onPageChanged: (int page) {
//                       setState(() {
//                         _currentPage = page;
//                       });
//                     },
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/images/logoRed.png',
//                                 ),
//                                 height: 200.0,
//                                 width: 200.0,
//                               ),
//                             ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               'Connect people\naround the world',
//                               style: kTitleStyle,
//                             ),
//                             SizedBox(height: 15.0),
//                             Text(
//                               'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
//                               style: kSubtitleStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/images/logoRed.png',
//                                 ),
//                                 height: 200.0,
//                                 width: 200.0,
//                               ),
//                             ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               'Live your life smarter\nwith us!',
//                               style: kTitleStyle,
//                             ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
//                               style: kSubtitleStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(40.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/images/logoRed.png',
//                                 ),
//                                 height: 200.0,
//                                 width: 200.0,
//                               ),
//                             ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               'Get a new experience\nof imagination',
//                               style: kTitleStyle,
//                             ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
//                               style: kSubtitleStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: _buildPageIndicator(),
//                 ),
//                 _currentPage != _numPages - 1
//                     ? Expanded(
//                         child: Align(
//                           alignment: FractionalOffset.bottomRight,
//                           child: FlatButton(
//                             onPressed: () {
//                               _pageController.nextPage(
//                                 duration: Duration(milliseconds: 500),
//                                 curve: Curves.ease,
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Text(
//                                   'Next',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22.0,
//                                   ),
//                                 ),
//                                 SizedBox(width: 10.0),
//                                 Icon(
//                                   Icons.arrow_forward,
//                                   color: Colors.white,
//                                   size: 30.0,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     : Text(''),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomSheet: _currentPage == _numPages - 1
//           ?  Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               stops: [0.1, 0.4, 0.7, 0.9],
//               colors: [
//                 Color(0xFF3594DD),
//                 Color(0xFF4563DB),
//                 Color(0xFF5036D5),
//                 Color(0xFF5B16D0),
//               ],
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 40.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Container(
//                   alignment: Alignment.centerRight,
//                   child: FlatButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Skip',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 400.0,
//                   child: PageView(
//                     physics: ClampingScrollPhysics(),
//                     controller: _pageController,
//                     onPageChanged: (int page) {
//                       setState(() {
//                         _currentPage = page;
//                       });
//                     },
//                     children: <Widget>[

//                       Padding(
//                         padding: EdgeInsets.all(40.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/images/logoRed.png',
//                                 ),
//                                 height: 200.0,
//                                 width: 200.0,
//                               ),
//                             ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               'Get a new experience\nof imagination',
//                               style: kTitleStyle,
//                             ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
//                               style: kSubtitleStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: _buildPageIndicator(),
//                 ),
//                 _currentPage != _numPages - 1
//                     ? Expanded(
//                         child: Align(
//                           alignment: FractionalOffset.bottomRight,
//                           child: FlatButton(
//                             onPressed: () {
//                               _pageController.nextPage(
//                                 duration: Duration(milliseconds: 500),
//                                 curve: Curves.ease,
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Text(
//                                   'Next',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22.0,
//                                   ),
//                                 ),
//                                 SizedBox(width: 10.0),
//                                 Icon(
//                                   Icons.arrow_forward,
//                                   color: Colors.white,
//                                   size: 30.0,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     : Text(''),
//               ],
//             ),
//           ),
//         )

//           // Navigator.push(
//           //         context,
//           //         MaterialPageRoute(builder: (context) => WelcomeScreen()),
//           //       )
//         //   Container(
//         //       // height: 100.0,
//         //       width: double.infinity,
//         //       color: Colors.white,
//         //       child: GestureDetector(
//         //         onTap: () => Navigator.push(
//         //           context,
//         //           MaterialPageRoute(builder: (context) => WelcomeScreen()),
//         //         ),
//         //         child: Center(
//         //              Future.delayed(
//         // const Duration(seconds: 3),
//         // () => Navigator.push(
//         //       context,
//         //       MaterialPageRoute(builder: (context) => WelcomeScreen()),
//         //     ));
//         //         ),
//         //       ),
//         //     )
//           : Text(''),
//     );
//   }
// }

// // class OnBoard extends StatefulWidget {
// //   static String id = 'onbaording_screen';
// //   @override
// //   _OnBoardState createState() => _OnBoardState();
// // }

// // class _OnBoardState extends State<OnBoard> {

// //   final int _numPages = 3;
// //   final PageController _pageController = PageController(initialPage: 0);
// //   int _currentPage = 0;

// //   List<Widget> _buildPageIndicator() {
// //     List<Widget> list = [];
// //     for (int i = 0; i < _numPages; i++) {
// //       list.add(i == _currentPage ? indicator(true) : indicator(false));
// //     }
// //     return list;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: AnnotatedRegion<SystemUiOverlayStyle>(
// //         value: SystemUiOverlayStyle.light,
// //         child: Container(
// //           decoration: getDecoration(),
// //           child: Padding(
// //             padding: EdgeInsets.symmetric(vertical: 10.0),
// //             child: Column(
// //               // crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: <Widget>[
// //                 Flexible(
// //                   // height: 500.0,
// //                   child: PageView(
// //                     physics: ClampingScrollPhysics(),
// //                     controller: _pageController,
// //                     onPageChanged: (int page) {
// //                       setState(() {
// //                         _currentPage = page;
// //                       });
// //                     },
// //                     children: <Widget>[

// //                       getField('Sign Up', 'assets/images/logoRed.png',"Get the services to your doorstep"),

// //                       getField('Services', 'assets/images/logoRed.png',"Get the advantage of the services right from any place"),

// //                       getField('Services', 'assets/images/logoRed.png',"Get the advantage of the services right from any place"),

// //                       // getField('Get Started', 'assets/images/logoRed.png',"Start using our services right now !!!")

// //                     ],
// //                   ),
// //                 ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: _buildPageIndicator(),
// //                 ),
// //                 _currentPage == _numPages - 1
// //                     ? Flexible(
// //                   child: Align(
// //                     child: Padding(
// //                       padding: EdgeInsets.symmetric(horizontal: 10.0),
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: <Widget>[
// //                           Padding(
// //                             padding:EdgeInsets.symmetric(horizontal: 15.0),
// //                             child: Text(
// //                               'Skip',
// //                               style: TextStyle(
// //                                   color: Colors.white, fontSize: 24.0),
// //                             ),
// //                           ),
// //                           getButton(_pageController),

// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 )
// //                     : Text(''),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
