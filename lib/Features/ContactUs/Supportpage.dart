// ignore_for_file: deprecated_member_use, file_names, use_build_context_synchronously, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:next/Features/ContactUs/SubmitIssuepage.dart';
import 'package:next/customWidget/profile_image_store.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _floatController;
  late AnimationController _gradientController;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 200), () {
      _headerController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _floatController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  // ====== LAUNCHERS ======
  Future<void> _launchWhatsApp() async {
    const phoneNumber = "2348123456789";
    final now = DateTime.now();
    final message = """
Hello Trigon Support 👋,

I’d like to make an inquiry about the app.

📱 Device: ${Platform.operatingSystem}
🕒 Time: $now
App: Trigon Mobile
""";

    final encodedMessage = Uri.encodeComponent(message);
    final uri = Uri.parse("https://wa.me/$phoneNumber?text=$encodedMessage");

    try {
      final launched =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not launch WhatsApp.")),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("WhatsApp not installed or unavailable.")),
      );
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@trigon.com',
      queryParameters: {'subject': 'Customer Support Request'},
    );

    try {
      final launched = await launchUrl(emailLaunchUri);
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unable to open email app.")),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to open email app.")),
      );
    }
  }

  Future<void> _launchMaps() async {
    const lat = 6.433126;
    const lng = 3.423345;
    const label = "Trigon HQ, Lagos";

    final googleMapsUri = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$lat,$lng($label)");
    final appleMapsUri = Uri.parse("https://maps.apple.com/?q=$lat,$lng");

    try {
      final launched = await launchUrl(
        Platform.isIOS ? appleMapsUri : googleMapsUri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open Maps.")),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Maps app not available.")),
      );
    }
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
              // ===== REPLACED HEADER FROM CODE 2 =====
              SizedBox(
                height: 220,
                child: Stack(
                  children: [
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
                                backgroundColor: Colors.white,
                                backgroundImage: ProfileImageStore.imageFile !=
                                        null
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
                                "Hi, Taiwo",
                                style: theme.textTheme.titleLarge!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "How can we help you today?",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                                  color: Colors.black.withOpacity(0.4),
                                  size: 18),
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

              // ===== REMAINDER OF CODE 1 =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Active Request",
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SupportOption(
                      iconWidget: Image.asset(
                        "assets/icons/icon-park-outline_thinking-problem.png",
                        width: 32,
                        height: 32,
                      ),
                      title: "Report an issue",
                      subtitle: "Average response time is 5 mins",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Submitissuepage()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Others",
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SupportOption(
                      iconWidget: Image.asset(
                        "assets/icons/uim_whatsapp.png",
                        width: 32,
                        height: 32,
                      ),
                      title: "Chat",
                      subtitle: "Average response time is 5 mins",
                      onTap: _launchWhatsApp,
                    ),
                    SupportOption(
                      icon: Icons.email_outlined,
                      title: "Email",
                      subtitle: "Average response time is 12 hours",
                      extraLine: "support@trigon.com",
                      onTap: _launchEmail,
                    ),
                    SupportOption(
                      icon: Icons.location_on_outlined,
                      title: "Office Address",
                      subtitle:
                          "23B, Ademola Adetokunbo Street, Lagos, Nigeria",
                      onTap: _launchMaps,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

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
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Our social media handles",
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Kindly reach us here",
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialMediaIcon(
                            icon: FontAwesomeIcons.xTwitter,
                            color: Colors.black,
                            url: "https://twitter.com/your_handle",
                          ),
                          SizedBox(width: 18),
                          SocialMediaIcon(
                            icon: FontAwesomeIcons.facebookF,
                            color: Color(0xFF1877F2),
                            url: "https://facebook.com/your_handle",
                          ),
                          SizedBox(width: 18),
                          SocialMediaIcon(
                            icon: FontAwesomeIcons.instagram,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFEDA75),
                                Color(0xFFFA7E1E),
                                Color(0xFFD62976),
                                Color(0xFF962FBF),
                                Color(0xFF4F5BD5),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            url: "https://instagram.com/your_handle",
                          ),
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
     floatingActionButton: FloatingActionButton(
  onPressed: () {},
  backgroundColor: const Color(0xFF0C56A6),
  shape: const CircleBorder(), // ensures it's circular
  child: ClipOval(
    child: Image.asset(
      "assets/icons/heroicons-solid_chat.png",
      width: 34,
      height: 34,
      fit: BoxFit.cover,
    ),
  ),
),

    );
  }
}

// === Updated SupportOption to handle image icons ===
class SupportOption extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final String title;
  final String subtitle;
  final String? extraLine;
  final VoidCallback onTap;

  const SupportOption({
    super.key,
    this.icon,
    this.iconWidget,
    required this.title,
    required this.subtitle,
    this.extraLine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
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
              child: iconWidget ??
                  Icon(icon, color: const Color(0xFF0C56A6), size: 30),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: Colors.grey[600])),
                  if (extraLine != null) ...[
                    const SizedBox(height: 2),
                    Text(extraLine!,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: const Color(0xFF0C56A6),
                          fontWeight: FontWeight.w500,
                        )),
                  ]
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

// SocialMediaIcon class unchanged
class SocialMediaIcon extends StatefulWidget {
  final IconData icon;
  final Color? color;
  final LinearGradient? gradient;
  final String url;

  const SocialMediaIcon({
    super.key,
    required this.icon,
    this.color,
    this.gradient,
    required this.url,
  });

  @override
  State<SocialMediaIcon> createState() => _SocialMediaIconState();
}

class _SocialMediaIconState extends State<SocialMediaIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 0.05,
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.05).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        _launchUrl(widget.url);
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: widget.icon == FontAwesomeIcons.facebookF
                ? BoxShape.circle
                : BoxShape.rectangle,
            borderRadius: widget.icon == FontAwesomeIcons.facebookF
                ? null
                : BorderRadius.circular(10),
            gradient: widget.gradient,
            color: widget.gradient == null ? widget.color : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 4,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
