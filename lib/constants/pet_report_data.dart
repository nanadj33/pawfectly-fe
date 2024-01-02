class PetReport {
  int id;
  String content;
  String report;
  DateTime dateTime;

  PetReport({
    required this.id,
    required this.content,
    required this.report,
    required this.dateTime,
  });
  factory PetReport.fromJson(Map<String, dynamic> json) {
    return PetReport(
      id: json["id"],
      content: json["content"],
      report: json["report_type"],
      dateTime: DateTime.parse(json["date_time"]),
    );
  }
}
