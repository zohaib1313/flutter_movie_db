import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_booking_app/core/theme/app_colors.dart';
import 'package:movie_booking_app/features/moviedetail/presenstation/screens/seat_selection_screen_two.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  int selectedDate = 0;
  int selectedSession = 0;
  final List<String> dates = [
    '5 Mar',
    '6 Mar',
    '7 Mar',
    '8 Mar',
    '9 Mar',
    '10 Mar',
    '11 Mar',
  ];
  final List<Map<String, dynamic>> sessions = [
    {
      'time': '12:30',
      'hall': 'Cinetech + Hall 1',
      'price': '50',
      'bonus': '2500',
    },
    {
      'time': '13:30',
      'hall': 'Cinetech + Hall 1',
      'price': '75',
      'bonus': '3000',
    },
    {
      'time': '12:30',
      'hall': 'Cinetech + Hall 1',
      'price': '50',
      'bonus': '2500',
    },
    {
      'time': '13:30',
      'hall': 'Cinetech + Hall 1',
      'price': '75',
      'bonus': '3000',
    },
  ];

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
                          'In Theaters December 22, 2021',
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60.h),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        top: 24.h,
                        right: 0,
                        bottom: 0,
                      ),
                      child: Text(
                        'Date',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.dark,
                          fontSize: 16.h,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 38.h,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: dates.length,
                        separatorBuilder: (_, __) => SizedBox(width: 12.w),
                        itemBuilder: (context, index) {
                          final isSelected = selectedDate == index;
                          return GestureDetector(
                            onTap: () => setState(() => selectedDate = index),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 22.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.blue
                                    : AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppColors.blue.withOpacity(
                                            0.18,
                                          ),
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Center(
                                child: Text(
                                  dates[index],
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: isSelected
                                        ? AppColors.light
                                        : AppColors.dark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.h,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 32.h),
                    SizedBox(
                      height: 260.h,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: sessions.length,
                        separatorBuilder: (_, __) => SizedBox(width: 20.w),
                        itemBuilder: (context, index) {
                          final session = sessions[index];
                          final isSelected = selectedSession == index;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => selectedSession = index),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 300.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.light,
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.blue
                                            : AppColors.lightGrey,
                                        width: 1.5.w,
                                      ),
                                      borderRadius: BorderRadius.circular(16.r),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: AppColors.blue
                                                    .withOpacity(0.08),
                                                blurRadius: 8,
                                                offset: Offset(0, 2),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    margin: EdgeInsets.only(bottom: 12.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 16.w,
                                            top: 12.h,
                                            right: 16.w,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                session['time'],
                                                style: textTheme.bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.dark,
                                                      fontSize: 15.h,
                                                    ),
                                              ),
                                              SizedBox(width: 8.w),
                                              Text(
                                                session['hall'],
                                                style: textTheme.bodySmall
                                                    ?.copyWith(
                                                      color: AppColors.grey,
                                                      fontSize: 13.h,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 8.h,
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/images/map.svg',
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 16.w,
                                    bottom: 12.h,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'From ',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: AppColors.grey,
                                          fontSize: 13.h,
                                        ),
                                      ),
                                      Text(
                                        '${session['price']}\$',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: AppColors.dark,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.h,
                                        ),
                                      ),
                                      Text(
                                        ' or ',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: AppColors.grey,
                                          fontSize: 13.h,
                                        ),
                                      ),
                                      Text(
                                        '${session['bonus']} bonus',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: AppColors.dark,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.h,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                bottom: 24.h,
                top: 0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SeatSelectionScreenTwo(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    'Select Seats',
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.light,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.h,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
