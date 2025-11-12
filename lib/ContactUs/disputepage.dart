// ignore_for_file: prefer_const_constructors, deprecated_member_use, file_names, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
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

  // colors matching screenshot
  static const Color blue = Color(0xFF0D47A1);
  static const Color lightPanel = Color.fromARGB(255, 238, 246, 255); // light blue background
  static const Color labelGrey = Color(0xFF8A96A6);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontal = (width > 500) ? width * 0.08 : width * 0.06;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Column(
            children: [
              Row(
                children: const [
                  Text("Dispute Details",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              ),
              Row(
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
            Column(
              children: [
                const Row(
                  children: [
                     CustomTitleText(
                    title: "Transaction Details",
                    fontWeight: FontWeight.w600, fontSize: 14
                  ),
                  ]
                ),
                  SizedBox(height:9),
                Card(
                  elevation: 1,
                  child: Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                    child: Row(
                     children: [
                      Text(
                        transactionDesc,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13))
                     ],
                    ),
                  ),
                ),
              ],
            ),
           
            SizedBox(height: 20),

            // NEW: Detailed Status panel with light blue background and exact connectors
            _label("Detailed Status"),
            
            SizedBox(height: 8),
            _detailedStatusV2(),

            SizedBox(height: 20),
            _label("Dispute Record"),
            SizedBox(height: 8),
            _disputeRecord(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: Colors.black,
      ),
    );
  }

  Widget _cardContainer({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _rowDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
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
            ),
          ),
        ],
      ),
    );
  }

  /// --- New Detailed Status (V2) to match latest screenshot ---
  Widget _detailedStatusV2() {
    
    const double nodeSize = 22;
    const double connectorWidth = 70; // short connector segments
    const double connectorHeight = 2;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: lightPanel,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Timeline row: node - connector 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First node
              _filledNode(blue, nodeSize),  SizedBox(width: 12),
              // connector 1 (short)
              _connectorSegment(blue, connectorWidth, connectorHeight),  SizedBox(width: 12),
              // middle node
              _filledNode(blue, nodeSize),  SizedBox(width: 12),
              // connector 2
              _connectorSegment(blue, connectorWidth, connectorHeight),  SizedBox(width: 12),
              // last node
              _filledNode(blue, nodeSize),
            ],
          ),

          SizedBox(height: 8),

          // Titles row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statusLabelColumn("Payment\nSuccessful", timelineDates[0]),
              _statusLabelColumn("Transaction\nSuccessful", timelineDates[1]),
              _statusLabelColumn("Recharge\nSuccessful", timelineDates[2]),
            ],
          ),

          SizedBox(height: 12),

          // Confirmation box 
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
                'DSTV has confirmed the recharge was successful and token was generated',
                style: TextStyle(
                  color: const Color.fromARGB(255, 34, 175, 2),
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
// nodes
  Widget _filledNode(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color, // filled blue
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.check, size: size * 0.8, color: Colors.white),
      ),
    );
  }

  // short blue connector segment between nodes
  Widget _connectorSegment(Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  // label + date column under each node (compact)
  Widget _statusLabelColumn(String title, String date) {
    return SizedBox(
      width: 100, // fixed width so three columns fit evenly
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
        // vertical timeline with small dot + vertical connecting line (if not last)
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
              SizedBox(height:5),
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
