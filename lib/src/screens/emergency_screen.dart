import 'package:animate_do/animate_do.dart';
import 'package:designs/src/src.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemButton {
  final IconData icon;
  final String text;
  final Color primaryColor;
  final Color secondaryColor;

  ItemButton(this.icon, this.text, this.primaryColor, this.secondaryColor);
}

final items = <ItemButton>[
  ItemButton(FontAwesomeIcons.carBurst, 'Motor Accident',
      const Color(0xff6989F5), const Color(0xff906EF5)),
  ItemButton(FontAwesomeIcons.plus, 'Medical Emergency',
      const Color(0xff66A9F2), const Color(0xff536CF6)),
  ItemButton(FontAwesomeIcons.masksTheater, 'Theft / Harrasement',
      const Color(0xffF2D572), const Color(0xffE06AA3)),
  ItemButton(FontAwesomeIcons.personBiking, 'Awards', const Color(0xff317183),
      const Color(0xff46997D)),
  ItemButton(FontAwesomeIcons.carBurst, 'Motor Accident',
      const Color(0xff6989F5), const Color(0xff906EF5)),
  ItemButton(FontAwesomeIcons.plus, 'Medical Emergency',
      const Color(0xff66A9F2), const Color(0xff536CF6)),
  ItemButton(FontAwesomeIcons.masksTheater, 'Theft / Harrasement',
      const Color(0xffF2D572), const Color(0xffE06AA3)),
  ItemButton(FontAwesomeIcons.personBiking, 'Awards', const Color(0xff317183),
      const Color(0xff46997D)),
  ItemButton(FontAwesomeIcons.carBurst, 'Motor Accident',
      const Color(0xff6989F5), const Color(0xff906EF5)),
  ItemButton(FontAwesomeIcons.plus, 'Medical Emergency',
      const Color(0xff66A9F2), const Color(0xff536CF6)),
  ItemButton(FontAwesomeIcons.masksTheater, 'Theft / Harrasement',
      const Color(0xffF2D572), const Color(0xffE06AA3)),
  ItemButton(FontAwesomeIcons.personBiking, 'Awards', const Color(0xff317183),
      const Color(0xff46997D)),
];

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> itemsMap = items
        .map((item) => FadeInLeft(
              duration: const Duration(milliseconds: 400),
              child: FatButton(
                  icon: item.icon,
                  text: item.text,
                  primaryColor: item.primaryColor,
                  secondaryColor: item.secondaryColor,
                  onPress: () {
                    print('Click! ${item.text}');
                  }),
            ))
        .toList();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 270),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ...itemsMap,
                ],
              ),
            ),
            const _Header()
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const IconHeader(
          icon: FontAwesomeIcons.plus,
          title: 'Medical assistance',
          subTitle: 'You have requested',
        ),
        Positioned(
            right: 10,
            top: 40,
            child: RawMaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
              child: const FaIcon(
                FontAwesomeIcons.ellipsisVertical,
                color: Colors.white,
              ),
            ))
      ],
    );
  }
}

class _FatButton extends StatelessWidget {
  const _FatButton();

  @override
  Widget build(BuildContext context) {
    return FatButton(
      icon: FontAwesomeIcons.carBurst,
      onPress: () {
        print('Hello there!');
      },
      text: 'Car accident',
    );
  }
}
