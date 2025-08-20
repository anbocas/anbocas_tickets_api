import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CompanyDetailsScreen extends StatefulWidget {
  const CompanyDetailsScreen({super.key, required this.company});

  final AnbocasCompanyModel company;

  static void navigate(BuildContext context, AnbocasCompanyModel company) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompanyDetailsScreen(company: company),
        ));
  }

  @override
  State<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.name ?? 'N/A'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : company != null
              ? ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(company!.currency?.name ?? 'N/A'),
                    const Gap(10),
                    Text('Brand Color: ${company!.brandColor ?? 'N/A'}'),
                    const Gap(10),
                    Text(
                        'Parent Commission: ${company!.parentCommission ?? 'N/A'}'),
                    const Gap(10),
                    Text('Logo: ${company!.logo ?? 'N/A'}'),
                    const Gap(10),
                  ],
                )
              : null,
    );
  }

  bool isLoading = false;
  AnbocasCompanyModel? company;
  final anbocasCompanies = AnbocasCompanies();

  @override
  void initState() {
    super.initState();
    getEvent();
  }

  void getEvent() async {
    setState(() {
      isLoading = true;
    });
    company = await anbocasCompanies.getCompany(widget.company.id ?? '');
    setState(() {
      isLoading = false;
    });
  }
}
