import 'package:covid_19_tracker_dashboard/app_config/styles/styles.dart';
import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final String label;
  final Color color;

  const LegendItem({Key? key, required this.label, required this.color})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(height: 12.0.sp, width: 12.0.sp, color: color),
        SizedBox(width: 8.0.sp),
        Text(label, style: AppStyles.semiBold.copyWith(fontSize: 11.0.sp)),
      ],
    );
  }
}
