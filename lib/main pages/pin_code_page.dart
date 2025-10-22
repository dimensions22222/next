import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next/main%20pages/verify_BVN_NIN_page.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final List<TextEditingController> _pinControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _pinFocus = List.generate(4, (_) => FocusNode());

  final List<TextEditingController> _confirmControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _confirmFocus = List.generate(4, (_) => FocusNode());

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    // ✅ Add listeners for all text fields to auto-update button state
    for (final c in [..._pinControllers, ..._confirmControllers]) {
      c.addListener(_updateButtonState);
    }
  }

  @override
  void dispose() {
    for (final c in [..._pinControllers, ..._confirmControllers]) {
      c.removeListener(_updateButtonState);
      c.dispose();
    }
    for (final f in [..._pinFocus, ..._confirmFocus]) {
      f.dispose();
    }
    super.dispose();
  }

  /// ✅ Update button enable state based on both PIN entries
  void _updateButtonState() {
    final pin = _pinControllers.map((c) => c.text).join();
    final confirm = _confirmControllers.map((c) => c.text).join();

    final shouldEnable =
        pin.length == 4 && confirm.length == 4 && pin == confirm;

    if (shouldEnable != _isButtonEnabled) {
      setState(() => _isButtonEnabled = shouldEnable);
    }
  }

  /// ✅ Handle text field behavior (move focus next/prev)
  void _onCharChanged(int index, List<TextEditingController> controllers,
      List<FocusNode> focusNodes, String value) {
    if (value.length > 1) {
      controllers[index].text = value.substring(value.length - 1);
      controllers[index].selection = const TextSelection.collapsed(offset: 1);
    }

    if (value.isNotEmpty && index < focusNodes.length - 1) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    } else if (index == focusNodes.length - 1 && value.isNotEmpty) {
      FocusScope.of(context).unfocus();
    }
  }

  /// ✅ Build a single PIN row
  Widget _buildPinRow(
      List<TextEditingController> controllers, List<FocusNode> focusNodes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(controllers.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 55,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400, width: 1.3),
          ),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 1,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
            onChanged: (value) {
              _onCharChanged(index, controllers, focusNodes, value.trim());
            },
          ),
        );
      }),
    );
  }

  void _goNext() {
    FocusScope.of(context).unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const IdentityVerificationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Top row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Container(
                    width: 50,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Text(
                "Create your PIN code",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please create your PIN code for login and secured payments",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 20),

              const Text("Enter PIN Code",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black87)),
              const SizedBox(height: 5),
              _buildPinRow(_pinControllers, _pinFocus),

              const SizedBox(height: 10),
              const Text("Confirm PIN",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black87)),
              const SizedBox(height: 10),
              _buildPinRow(_confirmControllers, _confirmFocus),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _goNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled
                        ? const Color(0xFF0D47A1)
                        : Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: _isButtonEnabled
                          ? Colors.white
                          : Colors.blueGrey[300],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
