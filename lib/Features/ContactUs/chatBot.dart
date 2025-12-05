// ignore_for_file: prefer_const_constructors, deprecated_member_use, unused_field

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class LiveChatPage extends StatefulWidget {
  const LiveChatPage({super.key});

  @override
  State<LiveChatPage> createState() => _LiveChatPageState();
}

class _LiveChatPageState extends State<LiveChatPage>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  bool _isTyping = false;
  List<Map<String, String>> messages = [
    {
      "sender": "bot",
      "text":
          "Hello, thanks for contacting Texa. Feel free to ask me any questions"
    },
  ];

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({"sender": "user", "text": text});
      _controller.clear();
      _isTyping = true;
    });

    _scrollToBottom();

    final response = await fetchMockReply(text);

    setState(() {
      _isTyping = false;
      messages.add({"sender": "bot", "text": response});
    });

    _scrollToBottom();
  }

  Future<String> fetchMockReply(String message) async {
    await Future.delayed(const Duration(seconds: 1));
    final lower = message.toLowerCase();
    if (lower.contains('account')) {
      return "You can open a new account via our website or app.";
    }
    if (lower.contains('limit')) {
      return "Please contact support@texa.com to increase your transaction limit.";
    }
    if (lower.contains('hello') || lower.contains('hi')) {
      return "Hi there! How can I assist you today?";
    }
    return "Thanks for your message! We'll respond shortly.";
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text('Live Chat',
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // Apply subtle black-to-white gradient
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF0F0F0), // very light gray (soft black)
              Colors.white,      // white
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  itemCount: messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_isTyping && index == messages.length) {
                      return ClipRect(
                        child: SizedBox(
                          width: double.infinity,
                          child: _typingIndicator(),
                        ),
                      );
                    }

                    final msg = messages[index];
                    return ClipRect(
                      child: msg["sender"] == "bot"
                          ? _botMessage(msg["text"]!)
                          : _userMessage(msg["text"]!),
                    );
                  },
                ),
              ),
              AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: _inputField(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _typingIndicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/bot2.png', width: 35, height: 35),
        const SizedBox(width: 8),
        Expanded(
          child: FadeIn(
            duration: const Duration(milliseconds: 400),
            child: SlideInLeft(
              from: 12,
              duration: Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: const [
                    Expanded(
                        child: Text("Texa is typing",
                            style: TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis)),
                    SizedBox(width: 6),
                    SizedBox(width: 24, height: 12, child: _DotTyping()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _botMessage(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BounceInDown(
          duration: const Duration(milliseconds: 500),
          child: Image.asset('assets/images/bot2.png', width: 40, height: 40),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: FadeInUp(
            duration: const Duration(milliseconds: 350),
            child: SlideInLeft(
              from: 10,
              duration: Duration(milliseconds: 280),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2))
                  ],
                ),
                child: Text(text,
                    style: const TextStyle(fontSize: 14), softWrap: true),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _userMessage(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: FadeInUp(
              duration: const Duration(milliseconds: 350),
              child: SlideInRight(
                from: 10,
                duration: Duration(milliseconds: 280),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(69, 187, 222, 251),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(text,
                      style: const TextStyle(fontSize: 14), softWrap: true),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ZoomIn(
          duration: const Duration(milliseconds: 300),
          child: const CircleAvatar(
              radius: 18,
              backgroundColor: Color.fromARGB(69, 187, 222, 251),
              child: Icon(Icons.person_3_outlined, color: Color(0xFF0D47A1))),
        ),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))
          ]),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => sendMessage(),
              decoration: InputDecoration(
                hintText: 'Write a reply...',
                filled: true,
                fillColor: const Color(0xFFF4F4F6),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: sendMessage,
            child: ZoomIn(
              duration: const Duration(milliseconds: 300),
              child: const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_upward, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotTyping extends StatefulWidget {
  const _DotTyping({Key? key}) : super(key: key);
  @override
  State<_DotTyping> createState() => _DotTypingState();
}

class _DotTypingState extends State<_DotTyping>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = _controller.value;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final t = (progress + i * 0.2) % 1.0;
            final size = 3.0 + (3.0 * (1 - (t - 0.5).abs() * 2));
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: size,
                height: size,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey));
          }),
        );
      },
    );
  }
}
