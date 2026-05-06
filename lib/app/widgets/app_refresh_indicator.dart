import 'package:flutter/material.dart';
import '../utils/utils.dart';
 
class AppRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const AppRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColours.primary,
      backgroundColor: isDark ? AppColours.backgroundDark : Colors.white,
      displacement: 40,
      child: child,
    );
  }
}
