class ClassModel {
  final String className;
  final String time;
  final String day;
  final String classroom;

  ClassModel({
    required this.className,
    required this.time,
    required this.day,
    required this.classroom,
  });

  // Convert JSON to ClassModel
  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      className: json['className'] as String,
      time: json['time'] as String,
      day: json['day'] as String,
      classroom: json['classroom'] as String,
    );
  }
}
