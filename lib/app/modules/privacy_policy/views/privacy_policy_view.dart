import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:al_khalifa/app/widgets/bullet_point.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
              ),
              title: Text(
                "Privacy & Service Policy",
                style: AppTextStyles.bold18,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Introduction", style: AppTextStyles.bold18),
                    Text(
                      "Welcome to Al Khalifa. Your privacy and trust are important to us. This Policy explains how we collect, use, and protect your personal information when you use our mobile application and services.",
                      style: AppTextStyles.regular14,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("How We Use Your Information", style: AppTextStyles.bold18),
                    Text(
                      "Your information is used to:",
                      style: AppTextStyles.regular14,
                    ),
                    SizedBox(height: 10),

                    BulletPoint(text: "Process and deliver your orders"),
                    BulletPoint(text: "Provide customer support"),
                    BulletPoint(text: "Improve our app and services"),
                    BulletPoint(
                        text:
                        "Send order updates, offers, and promotional notifications"),
                    BulletPoint(text: "Ensure secure transactions"),

                    SizedBox(height: 10),

                    Text(
                      "We do not sell or rent your personal information to third parties.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Payment Policy", style: AppTextStyles.bold18),
                    Text(
                      "Welcome to Al Khalifa. Your privacy and trust are important to us. This Policy explains how we collect, use, and protect your personal information when you use our mobile application and services.",
                      style: AppTextStyles.regular14,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Cancellation & Refund Policy", style: AppTextStyles.bold18),
                    BulletPoint(text: "Process and deliver your orders"),
                    BulletPoint(text: "Provide customer support"),
                    BulletPoint(text: "Improve our app and services"),
                    BulletPoint(
                        text:
                        "Send order updates, offers, and promotional notifications"),
                    BulletPoint(text: "Ensure secure transactions"),

                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivery Policy", style: AppTextStyles.bold18),
                    Text(
                      "Your information is used to:",
                      style: AppTextStyles.regular14,
                    ),
                    SizedBox(height: 10),

                    BulletPoint(text: "Process and deliver your orders"),
                    BulletPoint(text: "Provide customer support"),
                    BulletPoint(text: "Improve our app and services"),
                    BulletPoint(
                        text:
                        "Send order updates, offers, and promotional notifications"),
                    BulletPoint(text: "Ensure secure transactions"),

                    SizedBox(height: 10),

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


