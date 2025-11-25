class MetaModel {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  List? summary;
  int? page;
  String? filter;
  String? resource;
  String? message;
  int? code;
  List? errors;

  MetaModel({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.summary,
    this.page,
    this.filter,
    this.resource,
    this.message,
    this.code,
    this.errors,
  });

  MetaModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
    if (json['summary'] != null) {
      summary = [];
      json['summary'].forEach((v) {
        summary!.add(v);
      });
    }
    // page = json['page'];
    filter = json['filter'];
    resource = json['resource'];
    message = json['message'];
    code = json['code'];
    if (json['errors'] != null) {
      errors = [];
      json['errors'].forEach((v) {
        errors!.add(v);
      });
    }
  }
}
