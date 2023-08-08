import 'package:designs/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlideShowScreen extends StatelessWidget {
  const SlideShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Color.fromARGB(255, 113, 156, 236),
      body: Column(
        children: [
          Expanded(child: CustomSlideShow()),
          Expanded(child: CustomSlideShow()),
        ],
      ),
    );
  }
}

class CustomSlideShow extends StatelessWidget {
  const CustomSlideShow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<ThemeChanger>();
    return SlideShow(
      slides: [
        SvgPicture.asset('assets/svg/slide-1.svg'),
        SvgPicture.asset('assets/svg/slide-2.svg'),
        SvgPicture.asset('assets/svg/slide-3.svg'),
      ],
      primaryColor: (appTheme.darkTheme)
          ? appTheme.theme.colorScheme.secondary
          : const Color(0xffFF5A7E),
    );
  }
}
