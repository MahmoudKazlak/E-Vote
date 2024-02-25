class PollTopic {
  int id;
  String name;
  String insert_time;
  String type;
  String is_ended;
  
  PollTopic({required this.id, required this.name, required this.insert_time, required this.type, required this.is_ended});

  factory PollTopic.fromJson(Map<String, dynamic> json) {
    return PollTopic(
      id: json['id'],
      name: json['name'],
      insert_time: json['insert_time'],
      type: json['type'],
      is_ended: json['is_ended'],
    );
  }
}


