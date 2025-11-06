// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:next/customWidget/profile_image_store.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 200), () {
      _headerController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutCubic,
    ));

    final fadeAnimation = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeIn,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Support',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // ===== HEADER SECTION =====
SizedBox(
  height: 220, // <-- gives Stack a fixed height to layout properly
  child: Stack(
    children: [
      // header background animation
      SlideTransition(
        position: slideAnimation,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0C56A6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor:
                      const Color.fromARGB(255, 255, 255, 255),
                  backgroundImage: ProfileImageStore.imageFile != null
                      ? FileImage(ProfileImageStore.imageFile!)
                      : null,
                  child: ProfileImageStore.imageFile == null
                      ? const Icon(
                          Icons.person_outline,
                          color: Color(0xFF0D47A1),
                          size: 52,
                        )
                      : null,
                ),
                const SizedBox(height: 12),
                Text(
                  "Hi,Taiwo",
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "How can we help you today",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // floating decorative shapes
      AnimatedBuilder(
        animation: _floatController,
        builder: (context, child) {
          final float = 6 * _floatController.value;
          return Stack(
            children: [
              Positioned(
                left: 40,
                top: 24 + float,
                child: Icon(Icons.star,
                    color: Colors.black.withOpacity(0.4), size: 18),
              ),
              Positioned(
                left: 20,
                top: 90 - float,
                child: Transform.rotate(
                  angle: 0.8,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB3D235),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 80,
                bottom: 40 + float,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(158, 155, 39, 176),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 140,
                bottom: -25 - float,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(179, 113, 68, 121),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ],
  ),
),


              const SizedBox(height: 24),

              // ===== ACTIVE REQUEST =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Active Request",
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.12),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8F0FE),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.report_problem_outlined,
                            color: Color(0xFF0C56A6)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Report an issue",
                              style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Average response time is 5 mins",
                              style: theme.textTheme.bodySmall!.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ===== OTHERS =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Others",
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const SupportOption(
                icon: FontAwesomeIcons.whatsapp,
                title: "Chat",
                subtitle: "Average response time is 5 mins",
              ),
              const SupportOption(
                icon: Icons.email_outlined,
                title: "Email",
                subtitle: "Average response time is 12 hours",
                extraLine: "support@texa.com",
              ),
              const Divider(),
              const SupportOption(
                icon: Icons.location_on_outlined,
                title: "Office Address",
                subtitle: "23B, Ademola Adetokunbo Street, Lagos, Nigeria",
              ),

              const SizedBox(height: 24),

              // ===== SOCIAL MEDIA =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.12),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Our social media handles",
                        style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Kindly reach us here",
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialMediaIcon(icon: FontAwesomeIcons.xTwitter),
                          SizedBox(width: 18),
                          SocialMediaIcon(icon: FontAwesomeIcons.facebook),
                          SizedBox(width: 18),
                          SocialMediaIcon(icon: FontAwesomeIcons.instagram),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // ===== FLOATING CHAT BUTTON WITH ANIMATION =====
      floatingActionButton: ScaleTransition(
        scale: CurvedAnimation(
          parent: _headerController,
          curve: Curves.elasticOut,
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF0C56A6),
          child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
        ),
      ),
    );
  }
}

// ===== SUPPORT OPTION CARD =====
class SupportOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? extraLine;

  const SupportOption({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.extraLine,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFFE8F0FE),
              child: Icon(icon, color: const Color(0xFF0C56A6)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: Colors.grey[600])),
                  if (extraLine != null)
                    Text(extraLine!,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: const Color(0xFF0C56A6),
                          fontWeight: FontWeight.w500,
                        )),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// ===== SOCIAL MEDIA ICONS =====
class SocialMediaIcon extends StatelessWidget {
  final IconData icon;
  const SocialMediaIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(icon, color: const Color(0xFF0C56A6), size: 20),
    );
  }
}
