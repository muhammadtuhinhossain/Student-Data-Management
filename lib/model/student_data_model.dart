class StudentDataModel {
  final String id;
  final String name;
  final String course;
  final int rollNumber;

  StudentDataModel({required this.id, required this.name, required this.course, required this.rollNumber});

  factory StudentDataModel.fromJson(String id, Map<String, dynamic>json){
    return StudentDataModel(id: id,
        name: json['Name'],
        course: json['Course'],
        rollNumber: json['Roll']
    );
  }
}