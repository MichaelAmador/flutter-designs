import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../src.dart';

final routes = <_Route>[
  _Route(FontAwesomeIcons.slideshare, 'Slideshow', const SlideShowScreen()),
  _Route(FontAwesomeIcons.truckMedical, 'Emergency', const EmergencyScreen()),
  _Route(FontAwesomeIcons.heading, 'Headers', const HeaderScreen()),
  _Route(
      FontAwesomeIcons.peopleCarryBox, 'Animated box', const AnimationScreen()),
  _Route(FontAwesomeIcons.circleNotch, 'Progress bar',
      const CircularGraphicsScreen()),
  _Route(FontAwesomeIcons.pinterest, 'Pinterest', const PinterestScreen()),
  _Route(FontAwesomeIcons.mobile, 'Slivers', const SliverListScreen()),
];

class _Route {
  final IconData icon;
  final String title;
  final Widget screen;

  _Route(this.icon, this.title, this.screen);
}
