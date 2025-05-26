import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_upi_india/flutter_upi_india.dart';
import 'package:intl/intl.dart';
import 'package:rp_jewellery/business_logic/scheme_meta_bloc/scheme_meta_bloc.dart';
import 'package:rp_jewellery/business_logic/user_scheme_bloc/user_scheme_bloc.dart';
import 'package:rp_jewellery/repository/repository.dart';

class GoldSchemeScreen extends StatelessWidget {
  const GoldSchemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SchemeDetails();
  }
}

class SchemeMetaScreen extends StatelessWidget {
  const SchemeMetaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SchemeMetaBloc>().add(StartSchemeMeta());
    return BlocBuilder<SchemeMetaBloc, SchemeMetaState>(
      builder: (context, state) {
        if (state is SchemeMetaLoading) {
          return const CircularProgressIndicator();
        } else if (state is SchemeMetaSucess) {
          final data = state.data.data;
          return DefaultTabController(
            length: data?.length ?? 0,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('Gold Schemes'),
                bottom: TabBar(
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.symmetric(horizontal: 30),
                    isScrollable: true,
                    tabs: data?.map((e) => Tab(text: e.amount)).toList() ?? []),
              ),
              body: TabBarView(
                  children: data
                          ?.map(
                            (e) => SchemeDetailsTab(
                              id: e.id!,
                              title: e.name?.trim() ?? "",
                              monthlyAmount: int.parse(e.amount ?? "0"),
                              duration: '12 Months',
                              maturityAmount: int.parse(e.amount ?? "0") * 12,
                              benefits: const [
                                'Free insurance',
                                '5% discount on making charges',
                                'Priority delivery'
                              ],
                            ),
                          )
                          .toList() ??
                      []),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}

class SchemeDetailsTab extends StatelessWidget {
  final String title;
  final int monthlyAmount;
  final String duration;
  final int maturityAmount;
  final List<String> benefits;
  final int id;

  const SchemeDetailsTab({
    super.key,
    required this.title,
    required this.monthlyAmount,
    required this.duration,
    required this.maturityAmount,
    required this.benefits,
    required this.id,
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
                        Repository().selectScheme(id);

                        Future.delayed(Duration(seconds: 3), () {
                          context.read<UserSchemeBloc>().add(StartUserScheme());
                        });
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

class SchemeDetails extends StatelessWidget {
  const SchemeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserSchemeBloc>().add(StartUserScheme());
    return BlocBuilder<UserSchemeBloc, UserSchemeState>(
      builder: (context, state) {
        if (state is UserSchemeLoading) {
          return CircularProgressIndicator();
        } else if (state is UserSchemeSucess) {
          final data = state.data.data;
          if (data == null) return SchemeMetaScreen();

          return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text("Gold Saving Scheme")),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name ?? "",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("Monthly Amount: ₹${data.amount ?? ""}",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: data.paymentDetails?.length ?? 0,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        final item = data.paymentDetails![index];
                        final monthName = item.monthId ?? 'Unknown';
                        final isCurrent = item.isAvailable == 1;
                        final isPaid = item.isPaid == 1;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                      "${getMonthName(item.monthId ?? 1, item.yearId!)}, ${item.yearId}")),
                              isPaid
                                  ? Expanded(
                                      child: const Text("Paid",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  : Expanded(
                                      child: ElevatedButton(
                                        onPressed: isCurrent
                                            ? () {
                                                _showUpiApps(context);
                                              }
                                            : null,
                                        child: const Text("Pay"),
                                      ),
                                    ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is UserSchemeFailure) {
          return Text("something Went Wrong");
        }
        return SizedBox();
      },
    );
  }

  Future<void> _showUpiApps(BuildContext context) async {
    List<ApplicationMeta>? apps = await UpiPay.getInstalledUpiApplications(
        statusType: UpiApplicationDiscoveryAppStatusType.all);

    if (apps.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No UPI apps found!")),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: apps.map((app) {
          return ListTile(
            leading: app.iconImage(40),
            title: Text(app.upiApplication.getAppName()),
            onTap: () {
              Navigator.pop(context); // Close bottom sheet
              _initiateTransaction(app);
            },
          );
        }).toList(),
      ),
    );
  }

  Future<void> _initiateTransaction(ApplicationMeta appMeta) async {
    final response = await UpiPay.initiateTransaction(
      app: appMeta.upiApplication,
      receiverName: 'Surendar S',
      receiverUpiAddress: 'surendar9080@ybl',
      transactionRef: 'UPITXREF0001',
      transactionNote: 'A UPI Transaction',
      amount: "100",
    );
  }

  String getMonthName(int monthNumber, int year) {
    final date = DateTime(year, monthNumber); // any year works
    return DateFormat.MMM().format(date); // Returns short form like Jan, Feb
  }
}
