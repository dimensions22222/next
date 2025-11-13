// ignore_for_file: prefer_const_constructors, deprecated_member_use, file_names, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:next/main%20pages/dashboard_page.dart';
import 'package:next/main%20pages/utils/widgets/Custom_Title.dart';

class ElectricityDisputeDetailsPage extends StatefulWidget {
  final bool isSuccessful;
  const ElectricityDisputeDetailsPage({Key? key, this.isSuccessful = true})
      : super(key: key);

  @override
  State<ElectricityDisputeDetailsPage> createState() =>
      _ElectricityDisputeDetailsPageState();
}

class _ElectricityDisputeDetailsPageState
    extends State<ElectricityDisputeDetailsPage> {
  final ticketId = '12347890011982';
  final questionType = 'Debited but no token given';
  final transactionDesc = 'Electricity bill';
  final timelineDates = ['21-08 04:08:23', '21-08 04:08:23', '21-08 04:08:23'];

  static const Color blue = Color(0xFF0D47A1);
  static const Color lightPanel = Color.fromARGB(255, 238, 246, 255);
  static const Color labelGrey = Color(0xFF8A96A6);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontal = (width > 500) ? width * 0.08 : width * 0.06;

    return Scaffold(
       backgroundColor:const Color.fromARGB(247, 255, 255, 255),
      appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0.3,
  centerTitle: true,
  leading: IconButton(
    icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
    onPressed: () => Navigator.pop(context),
  ),
  title: Text(
    'Dispute Details',
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.home_outlined, color:Color(0xFF0D47A1)),
      onPressed: () {
        // 🏠 Navigate to Dashboard page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      },
    ),
  ],
),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dispute Details
            Column(
              children: [
                Row(
                  children: const [
                    Text("Dispute Details",
                        style:
                            TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
                SizedBox(height: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _rowDetail("Ticket ID:", ticketId),
                    Divider(color: Colors.grey.shade300),
                    _rowDetail("Question Type:", questionType),
                    Divider(),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),

            // Transaction Details
            Column(
              children: [
                const Row(
                  children: [
                    CustomTitleText(
                        title: "Transaction Details",
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ],
                ),
                SizedBox(height: 9),
                Card(
                  elevation: 1,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            transactionDesc,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Detailed Status
            _label("Detailed Status"),
            SizedBox(height: 8),
            _detailedStatusV2(),

            SizedBox(height: 20),

            // Dispute Record
            _label("Dispute Record"),
            SizedBox(height: 8),
            _disputeRecord(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Colors.black,
        ),
      );

  Widget _rowDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 90, maxWidth: 120),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Updated detailed status with dynamic success/failed UI
  Widget _detailedStatusV2() {
    const double nodeSize = 22;
    const double connectorWidth = 70;
    const double connectorHeight = 2;

    final bool success = widget.isSuccessful;

    final String statusMessage = success
        ? 'DSTV has confirmed the recharge was successful and token was generated'
        : 'DSTV has confirmed the recharge was not successful and token was not generated';

    final Color activeColor = success ? blue : Colors.red;
    final Color messageColor = success ? Color(0xFF22AF02) : Colors.red;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: lightPanel,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Timeline row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _filledNode(blue, nodeSize),
                SizedBox(width: 12),
                _connectorSegment(blue, connectorWidth, connectorHeight),
                SizedBox(width: 12),
                _filledNode(activeColor, nodeSize),
                SizedBox(width: 12),
                _connectorSegment(activeColor, connectorWidth, connectorHeight),
                SizedBox(width: 12),
                _filledNode(activeColor, nodeSize),
              ],
            ),
          ),

          SizedBox(height: 8),

          // Labels row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statusLabelColumn("Payment\nSuccessful", timelineDates[0]),
                _statusLabelColumn("Transaction\nSuccessful", timelineDates[1]),
                _statusLabelColumn(
                    success ? "Recharge\nSuccessful" : "Recharge\nUnsuccessful",
                    timelineDates[2]),
              ],
            ),
          ),

          SizedBox(height: 12),

          // Confirmation message
          Card(
            elevation: 1,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                statusMessage,
                style: TextStyle(
                  color: messageColor,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filledNode(Color color, double size) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Icon(Icons.check, size: size * 0.8, color: Colors.white),
        ),
      );

  Widget _connectorSegment(Color color, double width, double height) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      );

  Widget _statusLabelColumn(String title, String date) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 6),
          Text(
            date,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: labelGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _disputeRecord() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _recordItem(
            title: "Recharge successful",
            time: "Aug 13th, 2025 08:30:23",
            message:
                "We contacted DSTV and they confirmed that your purchase of 4.4KWh for ₦1,000 was successful",
            isLast: false,
          ),
          _recordItem(
            title: "Submit",
            time: "Aug 13th, 2025 08:30:23",
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _recordItem({
    required String title,
    required String time,
    String? message,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade400,
              ),
            ),
            SizedBox(height: 5),
            if (!isLast)
              Container(
                width: 1,
                height: 70,
                color: const Color.fromARGB(81, 141, 141, 141),
              ),
          ],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      color: Colors.black)),
              SizedBox(height: 4),
              Text(time,
                  style:
                      TextStyle(fontSize: 12.5, color: Colors.grey.shade700)),
              if (message != null) ...[
                SizedBox(height: 8),
                Text(message,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        height: 1.4)),
              ],
            ],
          ),
        )
      ],
    );
  }
}
