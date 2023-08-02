import 'package:flutter/material.dart';

class SliverListScreen extends StatelessWidget {
  const SliverListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        _MainScroll(),
        Positioned(bottom: -5, right: 0, child: _ButtonNewList())
      ],
    )));
  }
}

class _ButtonNewList extends StatelessWidget {
  const _ButtonNewList();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ButtonTheme(
        minWidth: size.width * 2,
        height: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffed6762),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(150)))),
          onPressed: () {},
          child: const Text(
            'Create new list',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 3),
          ),
        ));
  }
}

class _MainScroll extends StatelessWidget {
  const _MainScroll();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // const SliverAppBar(
        //   floating: true,
        //   elevation: 0,
        //   backgroundColor: Colors.red,
        //   title: Text('Hello'),
        //   centerTitle: true,
        // ),

        SliverPersistentHeader(
            floating: true,
            delegate: _SliverCustomHeaderDelegate(
                minHeight: 170,
                maxHeight: 200,
                child: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                    child: const _Header()))),
        SliverList(
            delegate: SliverChildListDelegate([
          ...itemsList,
          const SizedBox(
            height: 100,
          )
        ]))
      ],
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCustomHeaderDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverCustomHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

final itemsList = [
  const _ListItem('Orange', Color(0xffF08F66)),
  const _ListItem('Family', Color(0xffF2A38A)),
  const _ListItem('Subscriptions', Color(0xffF7CDD5)),
  const _ListItem('Books', Color(0xffFCEBAF)),
  const _ListItem('Orange', Color(0xffF08F66)),
  const _ListItem('Family', Color(0xffF2A38A)),
  const _ListItem('Subscriptions', Color(0xffF7CDD5)),
  const _ListItem('Books', Color(0xffFCEBAF)),
];

class _ListTasks extends StatelessWidget {
  const _ListTasks();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: itemsList.length,
      itemBuilder: (context, index) => itemsList[index],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: const Text(
            'New',
            style: TextStyle(color: Color(0xff532128), fontSize: 50),
          ),
        ),
        Stack(
          children: [
            const SizedBox(
              width: 100,
            ),
            Positioned(
              bottom: 8,
              child: Container(
                width: 120,
                height: 8,
                color: const Color(0xfff7cdd5),
              ),
            ),
            const Text(
              'List',
              style: TextStyle(color: Color(0xffD93a30), fontSize: 50),
            ),
          ],
        )
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final Color color;
  const _ListItem(
    this.title,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        height: 130,
        width: 100,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        child: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ));
  }
}
