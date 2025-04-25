import 'package:flutter/material.dart';

class GoldSchemeScreen extends StatelessWidget {
  const GoldSchemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Three schemes
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gold Schemes'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '5000'),
              Tab(text: '7000'),
              Tab(text: '10000'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SchemeDetailsTab(
              title: '1 Year Gold Scheme',
              monthlyAmount: 5000,
              duration: '12 Months',
              maturityAmount: 60000,
              benefits: [
                'Free insurance',
                '5% discount on making charges',
                'Priority delivery'
              ],
            ),
            SchemeDetailsTab(
              title: '6 Months Gold Scheme',
              monthlyAmount: 6000,
              duration: '6 Months',
              maturityAmount: 36000,
              benefits: ['2% discount on making charges', 'No hidden charges'],
            ),
            SchemeDetailsTab(
              title: 'Flexi Plan',
              monthlyAmount: 0,
              duration: 'Up to 12 Months',
              maturityAmount: 0,
              benefits: [
                'Choose your amount',
                'Withdraw anytime after 3 months',
                'No penalty for early withdrawal'
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SchemeDetailsTab extends StatelessWidget {
  final String title;
  final int monthlyAmount;
  final String duration;
  final int maturityAmount;
  final List<String> benefits;

  const SchemeDetailsTab({
    super.key,
    required this.title,
    required this.monthlyAmount,
    required this.duration,
    required this.maturityAmount,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 20),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (monthlyAmount > 0)
                    Text("Monthly Amount: ₹$monthlyAmount",
                        style: const TextStyle(fontSize: 16)),
                  Text("Duration: $duration",
                      style: const TextStyle(fontSize: 16)),
                  if (maturityAmount > 0)
                    Text("Maturity Amount: ₹$maturityAmount",
                        style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  const Text("Benefits:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  ...benefits.map((b) => Row(
                        children: [
                          const Icon(Icons.check,
                              size: 18, color: Colors.green),
                          const SizedBox(width: 6),
                          Expanded(child: Text(b)),
                        ],
                      )),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to Join screen or initiate scheme join
                      },
                      child: const Text("Join Now"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
