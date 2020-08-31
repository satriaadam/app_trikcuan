import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/utilities/styles.dart';
import 'package:trikcuan_app/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF546E7A),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              stops: [0.5, 0.7, 0.9],
              colors: [
                Colors.white,
                Colors.limeAccent[200],
                Colors.limeAccent,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context)=> LoginPage()),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.blueGrey[600],
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 510.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/undraw_Mobile_life_re_jtih.png',
                                ),
                                height: 250.0,
                                width: 250.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Selamat di Aplikasi\nmbahgiso',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/undraw_celebration_0jvk.png',
                                ),
                                height: 250.0,
                                width: 250.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Live your life smarter\nwith us!',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/undraw_finance_0bdk.png',
                                ),
                                height: 250.0,
                                width: 250.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Get a new experience\nof imagination',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.blueGrey[600],
                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.blueGrey[600],
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
        height: 100.0,
        width: double.infinity,
        color: Colors.blueGrey[600],
        child: GestureDetector(
          onTap: () async { 
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool("skipStartup", true);
            Navigator.push(context, new MaterialPageRoute(
            builder: (context) => LoginPage())
            );
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Get started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      )
          : Text(''),
    );
  }
}
