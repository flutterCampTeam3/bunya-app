class MedicationModel {
  final String medicationId;
  final DateTime createdAt;
  final String medicationName;
  final int pills;
  final int days;
  final String userId;
  final String before;
  final bool isCompleted;
  final bool todayPills;
  final String time;
  final bool isUpdate;
  final String updateTime;
  final String updateTimeDate;

  MedicationModel({
    required this.medicationId,
    required this.createdAt,
    required this.medicationName,
    required this.pills,
    required this.days,
    required this.userId,
    required this.before,
    required this.isCompleted,
    required this.todayPills,
    required this.time,
    required this.isUpdate,
    required this.updateTime,
    required this.updateTimeDate,
  });

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
        medicationId: json['medicationId'],
        createdAt: DateTime.parse(json['created_at']),
        medicationName: json['medicationName'] ?? "",
        pills: json['pills'] ?? 0,
        days: json['days'] ?? 0,
        userId: json['userId'],
        before: json['before'] ?? '',
        time: json['time'] ?? '',
        isCompleted: json['isCompleted'] ?? false,
        todayPills: json['todayPills'] ?? false,
        isUpdate: json['isUpdate'] ?? false,
        updateTime: json['updateTime'] ?? '',
        updateTimeDate: json['updateTimeDate'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'medicationId': medicationId,
      'created_at': createdAt.toIso8601String(),
      'medicationName': medicationName,
      'pills': pills,
      'days': days,
      'userId': userId,
      'before': before,
      'isCompleted': isCompleted,
      'time': time,
      'todayPills': todayPills,
      'isUpdate': isUpdate,
      'updateTime': updateTime,
      'updateTimeDate': updateTimeDate,
    };
  }
}
