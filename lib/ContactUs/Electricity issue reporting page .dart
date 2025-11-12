// ignore_for_file: deprecated_member_use, prefer_const_constructors, file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:next/ContactUs/disputepage.dart';
class ElectricityIssueReportPage extends StatefulWidget {
  const ElectricityIssueReportPage({Key? key}) : super(key: key);

  @override
  State<ElectricityIssueReportPage> createState() =>
      _ElectricityIssueReportPageState();
}

class _ElectricityIssueReportPageState
    extends State<ElectricityIssueReportPage> {
  final _descController = TextEditingController();
  String? _selectedIssue;
  final _issueOptions = [
    'My account was debited but token was not generated',
    'Wrong meter number',
    'Duplicate payment',
    'Other'
  ];

  // Example transaction data (adapt to your model)
  final _summary = {
    "product": "Electricity",
    "meter": "12342344004",
    "account": "HABEEB ILIAS",
    "amount": "₦1,000.00",
    "date": "August 13th, 2025 04:14:24",
    "logo": null // if you have an asset path, put it here
  };

  bool _submitting = false;

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  void _submitIssue() {
  if (_selectedIssue == null || _selectedIssue!.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select an issue type.')),
    );
    return;
  }

  // simulate loading
  setState(() => _submitting = true);

  Future.delayed(const Duration(milliseconds: 700), () {
    setState(() => _submitting = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ElectricityDisputeDetailsPage(
          isSuccessful: false, // or true, depending on backend result
        ),
      ),
    );
  });
}

  @override
  Widget build(BuildContext context) {
    // responsive padding based on width
    final w = MediaQuery.of(context).size.width;
    final horizontal = (w > 500) ? w * 0.08 : w * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Electricity",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: horizontal, right: horizontal, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step pill
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      color: Color.fromARGB(255, 13, 71, 161).withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.check_circle,
                        color: Color(0xFF0D47A1), size: 18),
                    SizedBox(width: 6),
                    Text('Step 3 of 3',
                        style: TextStyle(
                            color: Color(0xFF0D47A1),
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18),
            Text(
              'Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),

            // Summary card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 10,
                      offset: Offset(0, 4))
                ],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // product name + logo
                      Expanded(
                        child: Row(
                          children: [
                            // placeholder logo circle
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey.shade100,
                              child: _summary['logo'] == null
                                  ? Text('AEDC', style: TextStyle(fontSize: 10))
                                  : Image.asset(_summary['logo'] as String),
                            ),
                            SizedBox(width: 10),
                            Text(
                              _summary['product']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      // amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _summary['amount']!,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _summary['date']!,
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 11),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  // grid-like details
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _labelValue('Meter Number', _summary['meter']!),
                            SizedBox(height: 8),
                            _labelValue('Account Name', _summary['account']!),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      // right column can be used for anything else or left empty to match design
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            // placeholder for additional field
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            Text('Issue type',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            SizedBox(height: 8),

            // Issue type dropdown similar style to design
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade700, width: 0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedIssue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  hint: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                        'My account was debited but token was not generated',
                        style: TextStyle(fontSize: 13)),
                  ),
                  isExpanded: true,
                  items: _issueOptions
                      .map((s) =>
                          DropdownMenuItem(value: s, child: Text(s, maxLines: 2)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedIssue = v),
                ),
              ),
            ),

            SizedBox(height: 12),
            Text('Description', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),

            // description box
            Container(
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _descController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Please enter a description',
                ),
              ),
            ),

            Spacer(),

            // Submit button matching design
            SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitting ? null : _submitIssue,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Color(0xFF0D47A1),
                  ),
                  child: _submitting
                      ? SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text('Submit Issue',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _labelValue(String label, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontWeight: FontWeight.w700)),
        ],
      );
}
