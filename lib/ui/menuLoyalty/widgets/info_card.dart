import 'package:flutter/material.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';

class CardInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  const CardInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.blue : Colors.grey,
              size: 32,
            ),
            Text(
              label,
              style: MenuApps.copyWith(
                color: isActive ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
