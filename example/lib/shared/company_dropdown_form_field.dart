import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CompanyDropdownFormField extends StatefulWidget {
  const CompanyDropdownFormField({
    super.key,
    this.value,
    this.onChanged,
  });

  final AnbocasCompanyModel? value;
  final void Function(AnbocasCompanyModel? value)? onChanged;

  @override
  State<CompanyDropdownFormField> createState() =>
      _CompanyDropdownFormFieldState();
}

class _CompanyDropdownFormFieldState extends State<CompanyDropdownFormField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.value,
      items: anbocasCompanies
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e.name ?? 'N/A'),
            ),
          )
          .toList(),
      icon: const CircularProgressIndicator(),
      onChanged: widget.onChanged,
    );
  }

  bool isLoading = false;
  List<AnbocasCompanyModel> anbocasCompanies = [];
  final anbocasCompaniesSDK = AnbocasCompanies();

  @override
  void initState() {
    super.initState();
  }

  void getCompanies() async {
    setState(() {
      isLoading = true;
    });

    try {
      final res = await anbocasCompaniesSDK.getCompanies(paginate: false);
      anbocasCompanies = res.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}
