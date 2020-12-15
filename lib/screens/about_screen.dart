import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  _sendingMails() async {
    const url = 'mailto:mohmedmatrix999@gmail.com';
    openUrl(url);
  }

  _launchFaceBook() async {
    const url = 'https://www.facebook.com/Tiger-Technology-107176761051168';
    openUrl(url);
  }

  _launchLinkedIn() async {
    const url = 'https://www.linkedin.com/in/mhmd-elngar-1196a7139/';
    openUrl(url);
  }

  openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Expanded(
              child: AnimationLimiter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 450),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Text(
                          'تيجر هي شركه '
                          'مصريه تأسست حديثا '
                          'من اجل بناء مجتمع ذكي '
                          'وبناء تطبيقات حديثه '
                          'للأندرويد وللأيفون ',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 28,
                            ),
                            onPressed: _sendingMails,
                          ),
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                              size: 28,
                            ),
                            onPressed: _launchFaceBook,
                          ),
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.linkedin,
                              color: Color(0xFF15AABF),
                              size: 28,
                            ),
                            onPressed: _launchLinkedIn,
                          )
                        ],
                      )
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
}
