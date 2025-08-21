import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:example/shared/currency_dropdown_form_field.dart';
import 'package:example/shared/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';

class CompanyFormScreen extends StatefulWidget {
  const CompanyFormScreen({super.key, this.company});

  final AnbocasCompanyModel? company;

  static Future<AnbocasCompanyModel?> navigate(BuildContext context,
      [AnbocasCompanyModel? company]) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompanyFormScreen(company: company),
      ),
    );
  }

  @override
  State<CompanyFormScreen> createState() => _CompanyFormScreenState();
}

class _CompanyFormScreenState extends State<CompanyFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.company == null ? 'Create Company' : 'Update Company'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Gap(20),
          MyTextField(
            controller: name,
            hintText: 'Company Name',
          ),
          const Gap(20),
          CurrencyDropdownFormField(
            value: currency,
            onChanged: (value) {
              setState(() {
                currency = value;
              });
            },
          ),
          const Gap(20),
          MyTextField(
            controller: brandColor,
            hintText: 'Brand Color',
          ),
          const Gap(20),
          MyTextField(
            controller: location,
            hintText: 'Location',
          ),
          const Gap(20),
          MyTextField(
            controller: website,
            hintText: 'Website',
          ),
          const Gap(20),
          MyTextField(
            controller: phone,
            hintText: 'Phone',
          ),
          const Gap(20),
          MyTextField(
            controller: taxId,
            hintText: 'TaxId',
          ),
          const Gap(20),
          MyTextField(
            controller: supportPhone,
            hintText: 'Support Phone',
          ),
          const Gap(20),
          MyTextField(
            controller: supportEmail,
            hintText: 'Support Email',
          ),
          const Gap(20),
          MyTextField(
            controller: parentCommission,
            hintText: 'Parent Commission',
          ),
          const Gap(20),
          MyTextField(
            controller: parentId,
            hintText: 'Parent Id',
          ),
          const Gap(20),
          MyTextField(
            controller: logoFilePath,
            hintText: 'Logo FilePath',
          ),
          const Gap(20),
        ],
      ),
      bottomNavigationBar: MaterialButton(
        height: 50,
        minWidth: double.infinity,
        textColor: Colors.white,
        onPressed: _createCompany,
        color: Colors.blue,
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Submit'),
      ),
    );
  }

  final _anbocasCompanys = AnbocasCompanies();
  bool isLoading = false;

  final name = TextEditingController();
  AnbocasCurrencyModel? currency;
  final brandColor = TextEditingController();
  final location = TextEditingController();
  final website = TextEditingController();
  final phone = TextEditingController();
  final taxId = TextEditingController();
  final supportPhone = TextEditingController();
  final supportEmail = TextEditingController();
  final parentCommission = TextEditingController();
  final parentId = TextEditingController();
  final logoFilePath = TextEditingController();

  @override
  void initState() {
    super.initState();
    final company = widget.company;
    if (company == null) {
      name.text = 'Company 1';
      brandColor.text = '#0000ff';
      location.text = 'Remote';
      website.text = 'https://forwardcode.com';
      phone.text = '+911234567890';
      taxId.text = '';
      supportPhone.text = '+91123456890';
      supportEmail.text = 'example@yopmail.com';
      parentCommission.text = '';
      parentId.text = '';
      logoFilePath.text = '';
    } else {
      name.text = company.name ?? '';
      brandColor.text = company.brandColor ?? '';
      location.text = company.location ?? '';
      // website.text = company.website ?? '';
      phone.text = company.phoneNumber ?? '';
      taxId.text = company.taxId ?? '';
      // supportPhone.text = company.supportPhone ?? '';
      supportEmail.text = company.supportEmail ?? '';
      parentCommission.text = company.parentCommission ?? '';
      parentId.text = company.parentId ?? '';
      logoFilePath.text = company.logo ?? '';
    }
  }

  @override
  void dispose() {
    name.dispose();
    brandColor.dispose();
    location.dispose();
    website.dispose();
    phone.dispose();
    taxId.dispose();
    supportPhone.dispose();
    supportEmail.dispose();
    parentCommission.dispose();
    parentId.dispose();
    logoFilePath.dispose();
    super.dispose();
  }

  void _createCompany() async {
    setState(() {
      isLoading = true;
    });
    try {
      late final AnbocasCompanyModel company;

      if (widget.company == null) {
        company = await _anbocasCompanys.createCompany(
          name: name.text,
          currencyId: currency?.id ?? '',
          brandColor: brandColor.text,
          location: location.text,
          website: website.text,
          phone: phone.text,
          taxId: taxId.text,
          supportPhone: supportPhone.text,
          supportEmail: supportEmail.text,
          parentCommission: parentCommission.text,
          parentId: parentId.text,
          logoFilePath: logoFilePath.text,
        );
      } else {
        company = await _anbocasCompanys.updateCompany(
          companyId: widget.company?.id ?? '',
          name: name.text,
          currencyId: currency?.id ?? '',
          brandColor: brandColor.text,
          location: location.text,
          website: website.text,
          phone: phone.text,
          taxId: taxId.text,
          supportPhone: supportPhone.text,
          supportEmail: supportEmail.text,
          parentCommission: parentCommission.text,
          parentId: parentId.text,
          logoFilePath: logoFilePath.text,
        );
      }

      if (mounted) {
        toastification.show(
          title: const Text('Company created successfullly'),
          style: ToastificationStyle.minimal,
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 5),
        );
        Navigator.pop(context, company);
      }
    } catch (e) {
      toastification.show(
        title: const Text('Opps! something went wrong, Try Again'),
        style: ToastificationStyle.minimal,
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 5),
      );
    }

    setState(() {
      isLoading = false;
    });
  }
}
