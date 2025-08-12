import 'package:flutter/material.dart';

class CompaniesTabView extends StatefulWidget {
  const CompaniesTabView({super.key});

  @override
  State<CompaniesTabView> createState() => _CompaniesTabViewState();
}

class _CompaniesTabViewState extends State<CompaniesTabView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Companies'),
    );
  }
}
