import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:example/companies/company_details_screen.dart';
import 'package:example/companies/company_form_screen.dart';
import 'package:example/orders/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CompaniesTabView extends StatefulWidget {
  const CompaniesTabView({super.key});

  @override
  State<CompaniesTabView> createState() => _CompaniesTabViewState();
}

class _CompaniesTabViewState extends State<CompaniesTabView> {
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final companys = _companiesResponse?.data ?? [];

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: RefreshIndicator(
                  onRefresh: () async => getCompanys(true),
                  child: ListView.builder(
                    itemCount: companys.length,
                    itemBuilder: (context, index) {
                      final company = companys[index];
                      return ListTile(
                        onTap: () {
                          CompanyDetailsScreen.navigate(context, company);
                        },
                        title: Text(company.name ?? 'N/A'),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) =>
                              _itemBuilder(context, company),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 16,
                bottom: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    CompanyFormScreen.navigate(context).then(
                      (value) {
                        if (value != null) {
                          setState(() {
                            _companiesResponse = _companiesResponse?.copyWith(
                              data: [
                                value,
                                ...(_companiesResponse?.data ?? [])
                              ],
                            );
                          });
                        }
                      },
                    );
                  },
                  child: const Icon(Icons.create),
                ),
              )
            ],
          ),
        ),
        MaterialButton(
          height: 50,
          minWidth: double.infinity,
          textColor: Colors.white,
          onPressed: () {
            if (_companiesResponse?.currentPage != null &&
                _companiesResponse?.lastPage != null &&
                _companiesResponse!.currentPage! >=
                    _companiesResponse!.lastPage!) {
              toastification.show(
                title: const Text('Nothing to load.'),
                style: ToastificationStyle.minimal,
                type: ToastificationType.info,
                autoCloseDuration: const Duration(seconds: 5),
              );
            } else {
              getCompanys();
            }
          },
          color: Colors.blue,
          child: const Text('Load more'),
        )
      ],
    );
  }

  final _anbocasCompanies = AnbocasCompanies();
  bool _isLoading = false;
  AnbocasPaginatedResponse<List<AnbocasCompanyModel>>? _companiesResponse;

  @override
  void initState() {
    super.initState();
    getCompanys();
  }

  void getCompanys([bool refresh = false]) async {
    setState(() {
      _isLoading = true;
    });
    if (_companiesResponse == null || refresh) {
      _companiesResponse = await _anbocasCompanies.getCompanies(
        paginate: true,
        pageLength: 2,
      );
    } else {
      final prevCompanysResponse = _companiesResponse;
      _companiesResponse = await _anbocasCompanies.getCompanies(
        paginate: true,
        pageLength: 2,
        page: (_companiesResponse!.currentPage ?? 0) + 1,
      );

      _companiesResponse = _companiesResponse!.copyWith(
        data: [...prevCompanysResponse!.data, ..._companiesResponse!.data],
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  List<PopupMenuEntry> _itemBuilder(
    BuildContext context,
    AnbocasCompanyModel company,
  ) {
    return [
      PopupMenuItem(
        onTap: () => OrdersScreen.navigate(context, company),
        child: const Text('Orders'),
      ),
      PopupMenuItem(
        onTap: () {
          CompanyFormScreen.navigate(context, company);
        },
        child: const Text('Edit'),
      ),
      PopupMenuItem(
        onTap: () async {
          try {
            await _anbocasCompanies.deleteCompany(
              companyId: company.id ?? '',
            );

            toastification.show(
              title: const Text('Company deleted successfully.'),
              style: ToastificationStyle.minimal,
              type: ToastificationType.success,
              autoCloseDuration: const Duration(seconds: 5),
            );

            setState(() {
              _companiesResponse = _companiesResponse?.copyWith(
                data: (_companiesResponse?.data
                        .where(
                          (element) => element.id != company.id,
                        )
                        .toList() ??
                    []),
              );
            });
          } catch (e) {
            toastification.show(
              title: const Text('Opps! something went wrong, Try again.'),
              style: ToastificationStyle.minimal,
              type: ToastificationType.error,
              autoCloseDuration: const Duration(seconds: 5),
            );
          }
        },
        child: const Text('Delete'),
      ),
    ];
  }
}
