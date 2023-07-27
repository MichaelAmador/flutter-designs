import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final bool indicatorsUp;
  final Color primaryColor;
  final Color secondaryColor;
  final double bulletPrimary;
  final double bulletSecondary;
  const SlideShow(
      {super.key,
      required this.slides,
      this.indicatorsUp = false,
      this.primaryColor = Colors.blue,
      this.secondaryColor = Colors.grey,
      this.bulletPrimary = 15,
      this.bulletSecondary = 12});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SliderModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (BuildContext context) {
              Provider.of<_SliderModel>(context).primaryColor = primaryColor;
              Provider.of<_SliderModel>(context).secondaryColor =
                  secondaryColor;
              Provider.of<_SliderModel>(context).bulletPrimary = bulletPrimary;
              Provider.of<_SliderModel>(context).bulletSecondary =
                  bulletSecondary;
              return _ViewSlide(indicatorsUp: indicatorsUp, slides: slides);
            },
          ),
        ),
      ),
    );
  }
}

class _ViewSlide extends StatelessWidget {
  const _ViewSlide({
    required this.indicatorsUp,
    required this.slides,
  });

  final bool indicatorsUp;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (indicatorsUp) _Dots(slides.length),
        Expanded(child: _Slides(slides)),
        if (!indicatorsUp) _Dots(slides.length)
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int dots;
  const _Dots(this.dots);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(dots, (index) => _Dot(index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final slideModel = Provider.of<_SliderModel>(context);
    double size = 0;
    Color color = Colors.black;

    if (slideModel.currentPage >= index.toDouble() - .5 &&
        slideModel.currentPage < index.toDouble() + .5) {
      size = slideModel.bulletPrimary;
      color = slideModel.primaryColor;
    } else {
      size = slideModel._bulletSecondary;
      color = slideModel.secondaryColor;
    }

    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides(this.slides);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final controller = PageController();

  @override
  void initState() {
    controller.addListener(() {
      Provider.of<_SliderModel>(context, listen: false).currentPage =
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
        children: widget.slides.map((slide) => _Slide(widget: slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget widget;
  const _Slide({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: widget);
  }
}

class _SliderModel extends ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.grey;
  double _bulletPrimary = 15;
  double _bulletSecondary = 12;

  double get currentPage => _currentPage;

  Color get primaryColor => _primaryColor;

  Color get secondaryColor => _secondaryColor;

  set currentPage(double currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  set primaryColor(Color color) {
    _primaryColor = color;
  }

  set secondaryColor(Color color) {
    _secondaryColor = color;
  }

  double get bulletPrimary => _bulletPrimary;
  double get bulletSecondary => _bulletSecondary;

  set bulletPrimary(double size) {
    _bulletPrimary = size;
  }

  set bulletSecondary(double size) {
    _bulletSecondary = size;
  }
}
