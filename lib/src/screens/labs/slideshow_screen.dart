// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:designs/src/providers/slider_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlideShowScreenLab extends StatelessWidget {
  const SlideShowScreenLab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: const Scaffold(
        body: Center(
          child: Column(
            children: [Expanded(child: _Slides()), _Dots()],
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(0),
          _Dot(1),
          _Dot(2),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final pageIndex = Provider.of<SliderModel>(context).currentPage;
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: (pageIndex >= index.toDouble() - .5 &&
                    pageIndex < index.toDouble() + .5)
                ? Colors.blue
                : Colors.grey,
            shape: BoxShape.circle));
  }
}

class _Slides extends StatefulWidget {
  const _Slides();

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final controller = PageController();

  @override
  void initState() {
    controller.addListener(() {
      print('${controller.page}');
      Provider.of<SliderModel>(context, listen: false).currentPage =
          controller.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        controller: controller,
        children: const [
          _Slide(svg: 'assets/svg/slide-1.svg'),
          _Slide(svg: 'assets/svg/slide-2.svg'),
          _Slide(svg: 'assets/svg/slide-3.svg'),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String svg;
  const _Slide({required this.svg});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: SvgPicture.asset(svg));
  }
}
