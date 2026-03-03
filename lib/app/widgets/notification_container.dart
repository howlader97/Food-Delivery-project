import 'package:al_khalifa/app/data/app_colors.dart';
import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
    super.key,
    required this.notiTitle,
    required this.notiSubTitle,
    required this.time,
    required this.onDelete,
    required this.onMarkAsRead,
    required this.isRead,
  });
  final String notiTitle;
  final String notiSubTitle;
  final String time;
  final VoidCallback onDelete;
  final VoidCallback onMarkAsRead;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMarkAsRead,
      child: Container(
        decoration: BoxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.notiContainerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(notiTitle, style: AppTextStyles.medium16),


                      ],
                    ),
                    Text(notiSubTitle, style: AppTextStyles.regular12),
                    const SizedBox(height: 5,),
                    Row(children: [
                      Text(time, style: AppTextStyles.regular14),
                      Spacer(),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: isRead ? Colors.white : AppColors.greyColor,
                            borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: isRead ? Colors.white : AppColors.greyColor,
                        ),)
                      )
                    ],)

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
