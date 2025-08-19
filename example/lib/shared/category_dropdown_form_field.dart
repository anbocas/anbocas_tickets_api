import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';

class CategoryDropdownFormField extends StatefulWidget {
  const CategoryDropdownFormField({
    super.key,
    this.value,
    this.onChanged,
  });

  final AnbocasCategoryModel? value;
  final void Function(AnbocasCategoryModel? value)? onChanged;

  @override
  State<CategoryDropdownFormField> createState() =>
      _CategoryDropdownFormFieldState();
}

class _CategoryDropdownFormFieldState extends State<CategoryDropdownFormField> {
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
                  onTap: () => getCategories(),
                  child: const Icon(Icons.refresh),
                ),
                const Gap(8),
              ],
            ),
      onChanged: widget.onChanged,
    );
  }

  bool isLoading = false;
  List<AnbocasCategoryModel> anbocasCompanies = [];
  final anbocasCompaniesSDK = AnbocasCategories();

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void getCategories() async {
    setState(() {
      isLoading = true;
    });

    try {
      final res = await anbocasCompaniesSDK.getCategories(paginate: false);
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
