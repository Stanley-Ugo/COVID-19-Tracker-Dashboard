import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  Widget buildShimmerBox({
    double height = 20,
    double width = double.infinity,
    BorderRadius? radius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius ?? BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildShimmerBox(height: 16, width: 180.w), // "Daily New Cases"
          SizedBox(height: 10.h),

          buildShimmerBox(
            height: 250.h,
            radius: BorderRadius.circular(15.r),
          ), // Chart Placeholder
          SizedBox(height: 10.h),

          Divider(),
          SizedBox(height: 4.h),

          buildShimmerBox(
            height: 16,
            width: 220.w,
          ), // "Latest Case Distribution"
          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(
                child: buildShimmerBox(height: 120.h), // Pie chart
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      children: [
                        buildShimmerBox(height: 12.sp, width: 12.sp),
                        SizedBox(width: 8.w),
                        buildShimmerBox(height: 14.h, width: 80.w),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
          Divider(),
          SizedBox(height: 10.h),

          buildShimmerBox(height: 16, width: 200.w), // "Data Computation"
          SizedBox(height: 10.h),

          Column(
            children: List.generate(6, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (col) {
                    return buildShimmerBox(
                      height: 14.h,
                      width: col == 0 ? 50.w : 70.w,
                    );
                  }),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
