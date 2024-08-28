class AddTask {
  String taskName;
  String taskDefinition;
  String priority;
  String dueDate;
  String dueTime;
  bool isComplete;

  AddTask(
    this.taskName,
    this.taskDefinition,
    this.priority,
    this.dueDate,
    this.dueTime, {
    this.isComplete = false,
  });

  Map<String, dynamic> toJson() => {
        'taskName': taskName,
        'taskDefinition': taskDefinition,
        'priority': priority,
        'dueDate': dueDate,
        'dueTime': dueTime,
        'isComplete': isComplete,
      };

  factory AddTask.fromJson(Map<String, dynamic> json) {
    return AddTask(
      json['taskName'],
      json['taskDefinition'],
      json['priority'],
      json['dueDate'],
      json['dueTime'],
      isComplete: json['isComplete'] ?? false,
    );
  }
}
