import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1030 then we consider it a desktop
      builder: (context, constraints) {
        if (isDesktop(context)) {
          return desktop;
        }
        // If width it less then 1030 and more then 620 we consider it as tablet
        else if (isTablet(context)) {
          return tablet;
        }
        // Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }

  static bool isDesktop(BuildContext context) =>
      ResponsiveWrapper.of(context).isDesktop ||
      ResponsiveWrapper.of(context).isLargerThan(DESKTOP);

  /// We will modify based on our design dimension for each type.

  // This isMobile, isTablet, isDesktop
  static bool isMobile(BuildContext context) =>
      ResponsiveWrapper.of(context).isMobile ||
      ResponsiveWrapper.of(context).isSmallerThan(TABLET);

  static bool isTablet(BuildContext context) =>
      ResponsiveWrapper.of(context).isTablet &&
      MediaQuery.of(context).size.width >= 800;

  static BoxConstraints responsiveTableConstraints(BuildContext context) =>
      BoxConstraints(
          minWidth: 450,
          maxWidth: ResponsiveValue<double>(context,
              defaultValue: MediaQuery.of(context).size.width,
              valueWhen: [
                const Condition.largerThan(breakpoint: 1400, value: 1400)
              ]).value!,
          minHeight: 500);
}
