import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';

class CurrencyDropdownFormField extends StatefulWidget {
  const CurrencyDropdownFormField({
    super.key,
    this.value,
    this.onChanged,
  });

  final AnbocasCurrencyModel? value;
  final void Function(AnbocasCurrencyModel? value)? onChanged;

  @override
  State<CurrencyDropdownFormField> createState() =>
      _CurrencyDropdownFormFieldState();
}

class _CurrencyDropdownFormFieldState extends State<CurrencyDropdownFormField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.value,
      decoration: const InputDecoration(
        hintText: 'Select Currency',
        border: OutlineInputBorder(),
      ),
      items: anbocasCompanies
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e.name ?? 'N/A'),
            ),
          )
          .toList(),
      icon: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2.4),
            )
          : Row(
              children: [
                const Icon(Icons.arrow_drop_down),
                InkWell(
                  onTap: () => getCurrencies(),
                  child: const Icon(Icons.refresh),
                ),
                const Gap(8),
              ],
            ),
      onChanged: widget.onChanged,
    );
  }

  bool isLoading = false;
  List<AnbocasCurrencyModel> anbocasCompanies = [];
  final anbocasCompaniesSDK = AnbocasCurrency();

  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  void getCurrencies() async {
    setState(() {
      isLoading = true;
    });

    try {
      final res = await anbocasCompaniesSDK.getCurrencies(paginate: false);
      anbocasCompanies = res.data;
    } catch (e) {
      if (kDebugMode) print(e);
      toastification.show(
        title: const Text('Failed to fetch companies, Try again!'),
        style: ToastificationStyle.minimal,
        type: ToastificationType.info,
        autoCloseDuration: const Duration(seconds: 5),
      );
    }

    setState(() {
      isLoading = false;
    });
  }
}
