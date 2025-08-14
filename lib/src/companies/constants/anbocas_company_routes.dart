abstract final class AnbocasCompanyRoutes {
  static String getEvents = "/v1/events";
  static String getCompanies = "/v1/companies";
  static String getCompanyDetails(String id) => "/v1/companies/$id";
  static String createCompany = "/v1/companies/create";
  static String deleteCompany(String id) => "/v1/companies/$id";
  static String updateCompany(String id) => "/v1/companies/$id";
}
