import 'package:designs/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestScreen extends StatelessWidget {
  const PinterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: const Scaffold(
          body: Stack(children: [_PinteresGrid(), _PinterestMenuLocation()])),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  const _PinterestMenuLocation();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final show = context.watch<_MenuModel>().show;
    final appTheme = context.watch<ThemeChanger>().theme;
    return Positioned(
      bottom: 30,
      child: SizedBox(
          width: size.width,
          child: Align(
              child: PinterestMenu(
            show: show,
            backgrounColor: appTheme.scaffoldBackgroundColor,
            activeColor: appTheme.colorScheme.secondary,
            items: [
              PinterestButton(
                  onPressed: () {
                    print('object 1');
                  },
                  icon: Icons.home_outlined),
              PinterestButton(
                  onPressed: () {
                    print('object 2');
                  },
                  icon: Icons.search),
              PinterestButton(
                  onPressed: () {
                    print('object 3');
                  },
                  icon: Icons.notifications),
              PinterestButton(
                  onPressed: () {
                    print('object 4');
                  },
                  icon: Icons.supervised_user_circle_outlined),
            ],
          ))),
    );
  }
}

class _PinteresGrid extends StatefulWidget {
  const _PinteresGrid();

  @override
  State<_PinteresGrid> createState() => _PinteresGridState();
}

class _PinteresGridState extends State<_PinteresGrid> {
  final controller = ScrollController();
  double scrollLastPosition = 0;
  @override
  void initState() {
    controller.addListener(() {
      // print(controller.position);

      if (controller.offset > scrollLastPosition && controller.offset > 100) {
        context.read<_MenuModel>().show = false;
      } else {
        context.read<_MenuModel>().show = true;
      }

      scrollLastPosition = controller.offset;
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
    final List<int> items = List.generate(100, (index) => index);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.count(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          itemCount: items.length,
          // itemCount: widget.movies.length,
          itemBuilder: (context, index) {
            if (index == 1) {
              return Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  _PinteresItem(index)
                ],
              );
            }
            return _PinteresItem(index);
          },
        ),
      ),
    );
  }
}

class _PinteresItem extends StatelessWidget {
  final int index;
  const _PinteresItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }
}

class _MenuModel with ChangeNotifier {
  bool _show = true;

  bool get show => _show;

  set show(bool show) {
    _show = show;
    notifyListeners();
  }
}
