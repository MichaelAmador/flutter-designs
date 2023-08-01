import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FatButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color primaryColor;
  final Color secondaryColor;
  final Function()? onPress;
  const FatButton(
      {super.key,
      this.icon = FontAwesomeIcons.circle,
      required this.text,
      this.primaryColor = const Color(0xff6989f5),
      this.secondaryColor = const Color(0xff906ef5),
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Stack(children: [
        _Background(icon, primaryColor, secondaryColor),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 140,
              width: 40,
            ),
            FaIcon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.white,
            ),
            const SizedBox(
              width: 40,
            )
          ],
        )
      ]),
    );
  }
}

class _Background extends StatelessWidget {
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;
  const _Background(this.icon, this.primaryColor, this.secondaryColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.2),
                offset: const Offset(4, 6),
                blurRadius: 10),
          ],
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            primaryColor,
            secondaryColor,
          ])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(children: [
          Positioned(
            right: -20,
            top: -20,
            child: FaIcon(
              icon,
              size: 150,
              color: Colors.white.withOpacity(.2),
            ),
          )
        ]),
      ),
    );
  }
}
