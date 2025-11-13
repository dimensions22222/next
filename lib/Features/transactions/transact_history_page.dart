// transaction_history_page.dart
// ignore_for_file: unused_import, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next/Features/transactions/Modelz/transaction_item.dart';
import 'transaction_details_sheet.dart';
import 'cashback_details_page.dart';
import 'widgets/transaction_tile.dart';
import 'widgets/empty_state_view.dart';

class TransactHistoryPage extends StatefulWidget {
  const TransactHistoryPage({Key? key}) : super(key: key);

  @override
  State<TransactHistoryPage> createState() => _TransactHistoryPageState();
}

class _TransactHistoryPageState extends State<TransactHistoryPage>
    with SingleTickerProviderStateMixin {
  late final List<TransactionItem> _allTransactions;
  String _selectedCategory = 'All Categories';
  String _selectedStatus = 'All Status';
  TxStatus? _filterStatus;

  final List<String> _months = const [
    'Aug',
    'Jul',
    'Jun',
    'May',
    'Apr',
    'Mar',
    'Feb',
    'Jan'
  ];
  String _selectedMonth = 'Aug';

  final categories = [
    'All Categories',
    'Transfer from',
    'Transfer to',
    'Airtime',
    'Mobile Data',
    'Electricity',
    'TV',
    'Add Money'
  ];

  final statusOptions = [
    'All Status',
    'Successful',
    'Pending',
    'Failed',
    'To be paid',
    'Reversed'
  ];

  late final AnimationController _pageAnimationController;

  @override
  void initState() {
    super.initState();
    _pageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _pageAnimationController.forward();

    _allTransactions = List.generate(8, (i) {
      final date = DateTime.now().subtract(Duration(days: i * 2));
      return TransactionItem(
        id: 'tx_$i',
        title: (i % 3 == 0)
            ? 'Transfer from PEARL CRAIG'
            : (i % 3 == 1 ? 'Airtime' : 'Mobile Data'),
        subtitle: (i % 3 == 0)
            ? 'In: ₦2,521.00  Out: ₦1,700.00'
            : (i % 3 == 1 ? 'Airtime purchase' : 'Data bundle'),
        date: date,
        amount: (i % 2 == 0) ? -9000.0 : 8000.0,
        status: (i % 4 == 0)
            ? TxStatus.successful
            : (i % 4 == 1
                ? TxStatus.pending
                : (i % 4 == 2 ? TxStatus.failed : TxStatus.reversed)),
        type: (i % 3 == 0)
            ? 'Transfer'
            : (i % 3 == 1 ? 'Airtime' : 'Mobile Data'),
        isCashback: i == 2,
        cashbackAmount: i == 2 ? 17.50 : null,
        transactionNo: '1234789012347890098743$i',
        paymentMethod: 'Wallet',
      );
    });
  }

  @override
  void dispose() {
    _pageAnimationController.dispose();
    super.dispose();
  }

  List<TransactionItem> get _filteredTransactions {
    var list = _allTransactions;
    if (_selectedCategory != 'All Categories') {
      list = list
          .where((t) =>
              t.type == _selectedCategory || t.title.contains(_selectedCategory))
          .toList();
    }
    if (_filterStatus != null) {
      list = list.where((t) => t.status == _filterStatus).toList();
    }
    return list;
  }

  void _setStatusFilter(String s) {
    setState(() {
      _selectedStatus = s;
      switch (s) {
        case 'Successful':
          _filterStatus = TxStatus.successful;
          break;
        case 'Pending':
          _filterStatus = TxStatus.pending;
          break;
        case 'Failed':
          _filterStatus = TxStatus.failed;
          break;
        case 'Reversed':
          _filterStatus = TxStatus.reversed;
          break;
        case 'To be paid':
          _filterStatus = TxStatus.toBePaid;
          break;
        default:
          _filterStatus = null;
      }
    });
  }

  void _openTransactionDetails(TransactionItem item) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(247, 255, 255, 255),
      context: context,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.86,
        child: TransactionDetailsSheet(item: item),
      ),
    );
  }

  void _openCashbackDetails() => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const CashbackDetailsPage()),
      );

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTransactions;
    const mainBlue = Color(0xFF0D47A1);
    final gradientBg = BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade700, Colors.blue.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4))
      ],
    );

    // ------------------ Top Summary ------------------ //
    Widget buildTopSummary() {
  const inAmount = '₦2,521.00';
  const outAmount = '₦1,700.00';

  final curvedAnimation = CurvedAnimation(
    parent: _pageAnimationController,
    curve: Curves.easeInOut,
  );

  return FadeTransition(
    opacity: curvedAnimation,
    child: ScaleTransition(
      scale: Tween<double>(begin: 0.95, end: 1.0)
          .chain(CurveTween(curve: Curves.easeOutBack))
          .animate(curvedAnimation),
      child: Container(
        decoration: gradientBg,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Month selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedMonth,
                  items: _months
                      .map((m) => DropdownMenuItem(
                            value: m,
                            child: Text(m,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedMonth = val);
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: Colors.black54,
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shimmer In Amount
                  ShimmerText(
                    text: 'In $inAmount',
                    baseColor: Colors.white,
                    highlightColor: Colors.white70,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  // Shimmer Out Amount
                  ShimmerText(
                    text: 'Out $outAmount',
                    baseColor: Colors.white70,
                    highlightColor: Colors.white54,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Analysis clicked')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0D47A1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
              ),
              child: const Text('Analysis',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ],
        ),
      ),
    ),
  );
}

    // ------------------ Dropdowns ------------------ //
    Widget buildDropdowns() => Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color.fromARGB(255, 13, 71, 161)
                          .withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: mainBlue.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    items: categories
                        .map((cat) => DropdownMenuItem<String>(
                              value: cat,
                              child: Text(cat,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedCategory = value);
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color.fromARGB(255, 13, 71, 161)
                          .withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: mainBlue.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedStatus,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    items: statusOptions
                        .map((s) => DropdownMenuItem<String>(
                              value: s,
                              child: Text(s,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) _setStatusFilter(value);
                    },
                  ),
                ),
              ),
            ),
          ],
        );

    // ------------------ Transaction List ------------------ //
    Widget buildTransactionList() => filtered.isEmpty
        ? EmptyStateView(
            onPrimary: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('View Analysis'))))
        : ListView.separated(
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, index) {
              final t = filtered[index];
              return TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 350 + index * 50),
                curve: Curves.easeOutBack,
                tween: Tween(begin: 0, end: 1),
                builder: (_, value, child) => Opacity(
                  opacity: value.clamp(0.0, 1.0), // SAFE CLAMP
                  child: Transform.translate(
                      offset: Offset(0, (1 - value) * 20), child: child),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: t.amount > 0
                        ? Colors.green.shade50
                        : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child:
                      TransactionTile(item: t, onTap: () => _openTransactionDetails(t)),
                ),
              );
            },
          );

    // ------------------ Scaffold ------------------ //
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Center(
          child: Text('Transactions',
              style: TextStyle(fontWeight: FontWeight.w700)),
        ),
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Downloading...'))),
            child: const Text('Download', style: TextStyle(color: mainBlue)),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 800;

            if (isTablet) {
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        buildDropdowns(),
                        const SizedBox(height: 12),
                        buildTopSummary(),
                        const SizedBox(height: 12),
                        Expanded(child: buildTransactionList()),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.card_giftcard),
                              label: const Text('Cashback Details'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _openCashbackDetails,
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: () => setState(() {
                                _selectedCategory = 'All Categories';
                                _selectedStatus = 'All Status';
                                _filterStatus = null;
                              }),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: mainBlue),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text('Reset Filters',
                                  style: TextStyle(color: mainBlue)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Select a transaction to view details',
                                  style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 120,
                                child: Image.asset('assets/placeholder.png',
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.receipt_long,
                                            size: 80)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildDropdowns(),
                  const SizedBox(height: 12),
                  buildTopSummary(),
                  const SizedBox(height: 9),
                  Expanded(child: buildTransactionList()),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.card_giftcard),
                        label: const Text('Cashback Details'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D47A1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _openCashbackDetails,
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () => setState(() {
                          _selectedCategory = 'All Categories';
                          _selectedStatus = 'All Status';
                          _filterStatus = null;
                        }),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: mainBlue),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Reset Filters',
                            style: TextStyle(color: mainBlue)),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
    
  }
}
class ShimmerText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Color baseColor;
  final Color highlightColor;

  const ShimmerText({
    Key? key,
    required this.text,
    required this.style,
    required this.baseColor,
    required this.highlightColor,
  }) : super(key: key);

  @override
  State<ShimmerText> createState() => _ShimmerTextState();
}

class _ShimmerTextState extends State<ShimmerText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
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
        return ShaderMask(
          shaderCallback: (bounds) {
            final gradient = LinearGradient(
              colors: [widget.baseColor, widget.highlightColor, widget.baseColor],
              stops: const [0.1, 0.5, 0.9],
              begin: Alignment(-1.0 - _controller.value * 2, 0),
              end: Alignment(1.0 - _controller.value * 2, 0),
            );
            return gradient.createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: Text(widget.text, style: widget.style),
        );
      },
    );
  }
}
