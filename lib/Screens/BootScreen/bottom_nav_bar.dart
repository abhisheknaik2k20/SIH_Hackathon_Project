import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class CustomGNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;
  final ColorScheme colorScheme;

  const CustomGNav({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border:
            Border.all(color: colorScheme.primary.withOpacity(0.3), width: 2),
        color: colorScheme.surface,
      ),
      child: GNav(
        rippleColor: colorScheme.primary.withOpacity(0.2),
        hoverColor: colorScheme.primary.withOpacity(0.1),
        gap: 8,
        activeColor: colorScheme.primary,
        iconSize: 24,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: colorScheme.primary.withOpacity(0.1),
        color: colorScheme.onSurface,
        tabs: const [
          GButton(
            icon: LineIcons.home,
            text: 'Home',
          ),
          GButton(
            icon: LineIcons.heart,
            text: 'Likes',
          ),
          GButton(
            icon: LineIcons.wiredNetwork,
            text: 'Forum',
          ),
          GButton(
            icon: LineIcons.user,
            text: 'Profile',
          ),
        ],
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
      ),
    );
  }
}
