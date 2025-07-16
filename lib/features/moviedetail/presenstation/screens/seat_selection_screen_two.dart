import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_booking_app/core/theme/app_colors.dart';

class SeatSelectionScreenTwo extends StatefulWidget {
  const SeatSelectionScreenTwo({super.key});

  @override
  State<SeatSelectionScreenTwo> createState() => _SeatSelectionScreenTwoState();
}

class _SeatSelectionScreenTwoState extends State<SeatSelectionScreenTwo> {
  static const int rows = 10;
  static const int cols = 16;

  List<List<int>> seatMap = List.generate(
    rows,
    (i) => List.generate(
      cols,
      (j) => (i == 9)
          ? 2
          : (i == 3 && j == 7)
          ? 3
          : (i == 0 || j == 0 || j == cols - 1)
          ? 0
          : 1,
    ),
  );
  int selectedRow = 3;
  int selectedCol = 7;
  int seatCount = 1;

  double get totalPrice => 50.0 * seatCount;

  void selectSeat(int row, int col) {
    setState(() {
      if (seatMap[row][col] == 1 || seatMap[row][col] == 2) {
        // Only allow one selected seat for this UI
        for (int i = 0; i < rows; i++) {
          for (int j = 0; j < cols; j++) {
            if (seatMap[i][j] == 3) seatMap[i][j] = (i == 9) ? 2 : 1;
          }
        }
        seatMap[row][col] = 3;
        selectedRow = row;
        selectedCol = col;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.light,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.dark,
                      size: 24.h,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "The King's Man",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark,
                            fontSize: 20.h,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'March 5, 2021  |  12:30 Hall 1',
                          style: textTheme.bodySmall?.copyWith(
                            color: AppColors.blue,
                            fontSize: 14.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40.w),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.lightGrey,
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    'SCREEN',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.grey,
                      fontSize: 12.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 8.h,
                    ),
                    child: CustomPaint(
                      painter: _ScreenCurvePainter(),
                      child: SizedBox(height: 18.h, width: double.infinity),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(rows, (row) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(cols, (col) {
                                int seatType = seatMap[row][col];
                                Color color;
                                if (seatType == 0) {
                                  color = AppColors.lightGrey;
                                } else if (seatType == 1) {
                                  color = const Color(0xFF61C3F2); // Regular
                                } else if (seatType == 2) {
                                  color = const Color(0xFF564CA3); // VIP
                                } else {
                                  color = const Color(0xFFCD9D0F); // Selected
                                }
                                return Padding(
                                  padding: EdgeInsets.all(3.w),
                                  child: GestureDetector(
                                    onTap: () => selectSeat(row, col),
                                    child: Container(
                                      width: 16.w,
                                      height: 16.w,
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 32.w, bottom: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _CircleButton(icon: Icons.add, onTap: () {}),
                        SizedBox(width: 12.w),
                        _CircleButton(icon: Icons.remove, onTap: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.light,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(
                  height: 32.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _LegendItem(
                        color: const Color(0xFFCD9D0F),
                        label: 'Selected',
                      ),
                      _LegendItem(
                        color: AppColors.lightGrey,
                        label: 'Not available',
                      ),
                      _LegendItem(
                        color: const Color(0xFF564CA3),
                        label: 'VIP (150\$)',
                      ),
                      _LegendItem(
                        color: const Color(0xFF61C3F2),
                        label: 'Regular (50 \$)',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${selectedCol + 1}',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(' / ', style: textTheme.bodyMedium),
                      Text(
                        '${selectedRow + 1} row',
                        style: textTheme.bodyMedium,
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.close,
                          size: 18.w,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.light,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price',
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          Text(
                            '${totalPrice.toInt()}',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 28.w),
                        ),
                        child: Text(
                          'Proceed to pay',
                          style: textTheme.bodyLarge?.copyWith(
                            color: AppColors.light,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 13.h),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.h,
        height: 36.h,
        decoration: BoxDecoration(
          color: AppColors.light,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.blue, size: 22.w),
      ),
    );
  }
}

class _ScreenCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blue.withOpacity(0.18)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
