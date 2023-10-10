import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newtest/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../local_storage/local_storage_helper.dart';

class PreLoginView extends StatefulWidget {
  const PreLoginView({Key? key}) : super(key: key);

  @override
  PreLoginViewState createState() => PreLoginViewState();
}

class PreLoginViewState extends State<PreLoginView> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    await SharedPreferenceHelper.setPreLogin(1);
    Get.offAllNamed(Routes.LOGIN);
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/img/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.white);

    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: bodyStyle,
      pageColor: Colors.transparent,
    );

    return Stack(
      children: [
        Image.asset(
          'assets/img/hehe.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
        IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.transparent,
          allowImplicitScrolling: true,
          pages: [
            PageViewModel(
              title: 'My Event',
              body: '',
              footer: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 43.w,
                ),
                child: Text(
                  'Discover and search for nearby event based on your interests and preferred time. Dive into endless possibilities!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: bgWhite,
                      fontWeight: FontWeight.w500),
                ),
              ),
              decoration: pageDecoration.copyWith(
                bodyFlex: 10,
                imageFlex: 6,
              ),
            ),
            PageViewModel(
              title: 'My Event',
              body: '',
              footer: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 43.w,
                ),
                child: Text(
                  'Search and explore your favorite cosplayer. Get updates on event and discography, and immerse yourself in their world.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: bgWhite,
                      fontWeight: FontWeight.w500),
                ),
              ),
              decoration: pageDecoration.copyWith(
                bodyFlex: 10,
                imageFlex: 6,
              ),
            ),
           PageViewModel(
              title: 'My Event',
              body: '',
              footer: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 43.w,
                ),
                child: Text(
                  'Set reminders, and receive notifications. Stay organized and make the most of your busy life.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: bgWhite,
                      fontWeight: FontWeight.w500),
                ),
              ),
              decoration: pageDecoration.copyWith(
                bodyFlex: 10,
                imageFlex: 6,
              ),
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () =>
              _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: false,

          back: Icon(
            Icons.arrow_back,
            color: bgWhite,
          ),
          skip: Text('Skip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: bgWhite,
              )),
          next: Icon(
            Icons.arrow_forward,
            color: bgWhite,
          ),
          done: Text('Done',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: bgWhite,
              )),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: DotsDecorator(
            size: const Size(10.0, 10.0),
            color: const Color(0xFFBDBDBD),
            activeColor: bgWhite,
            activeSize: const Size(22.0, 10.0),
            activeShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ],
    );
  }
}
