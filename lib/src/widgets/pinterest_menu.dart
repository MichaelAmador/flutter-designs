import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestMenu extends StatelessWidget {
  final bool show;
  final Color backgrounColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<PinterestButton> items;
  // = [
  //   PinterestButton(
  //       onPressed: () {
  //         print('object 1');
  //       },
  //       icon: Icons.home_outlined),
  //   PinterestButton(
  //       onPressed: () {
  //         print('object 2');
  //       },
  //       icon: Icons.search),
  //   PinterestButton(
  //       onPressed: () {
  //         print('object 3');
  //       },
  //       icon: Icons.notifications),
  //   PinterestButton(
  //       onPressed: () {
  //         print('object 4');
  //       },
  //       icon: Icons.supervised_user_circle_outlined),
  // ];

  const PinterestMenu(
      {super.key,
      this.show = true,
      this.backgrounColor = Colors.white,
      this.activeColor = Colors.black,
      this.inactiveColor = Colors.blueGrey,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: (show) ? 1 : 0,
        child: Builder(builder: (context) {
          context.watch<_MenuModel>().backgroundColor = backgrounColor;
          context.watch<_MenuModel>().activeColor = activeColor;
          context.watch<_MenuModel>().inactiveColor = inactiveColor;
          return _PinterestMenuBackground(
            child: _MenuItems(menuItems: items),
          );
        }),
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;
  const _PinterestMenuBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.watch<_MenuModel>().backgroundColor;
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black45,
                // offset: Offset(2, 2),
                blurRadius: 10,
                spreadRadius: -5)
          ]),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;
  const _MenuItems({required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length,
          (index) => _PinterestMenuItem(index: index, item: menuItems[index])),
    );
  }
}

class _PinterestMenuItem extends StatelessWidget {
  final int index;
  final PinterestButton item;
  const _PinterestMenuItem({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final modelProvider = context.watch<_MenuModel>();
    return GestureDetector(
      onTap: () {
        context.read<_MenuModel>().itemSelected = index;
        item.onPressed!();
      },
      child: Container(
        child: Icon(
          item.icon,
          size: (modelProvider.itemSelected == index) ? 28 : 25,
          color: (modelProvider.itemSelected == index)
              ? modelProvider.activeColor
              : modelProvider.inactiveColor,
        ),
      ),
    );
  }
}

class PinterestButton {
  final void Function()? onPressed;
  final IconData icon;

  PinterestButton({required this.onPressed, required this.icon});
}

class _MenuModel extends ChangeNotifier {
  int _itemSelected = 0;
  Color _backgroundColor = Colors.white;
  Color _activeColor = Colors.black;
  Color _inactiveColor = Colors.blueGrey;

  int get itemSelected => _itemSelected;
  Color get backgroundColor => _backgroundColor;
  Color get activeColor => _activeColor;
  Color get inactiveColor => _inactiveColor;

  set itemSelected(int index) {
    _itemSelected = index;
    notifyListeners();
  }

  set backgroundColor(Color color) {
    _backgroundColor = color;
  }

  set activeColor(Color color) {
    _activeColor = color;
  }

  set inactiveColor(Color color) {
    _inactiveColor = color;
  }
}
