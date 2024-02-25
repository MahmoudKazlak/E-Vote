class PollTopicCandidate {
  int id;
  int candidate_id;
  int candidate_user_id;
  String name;
  int age;
  int candidate_votes_count;
  bool is_checked;
    
  PollTopicCandidate({required this.id,required this.candidate_id,required this.candidate_user_id, required this.name, required this.age, required this.candidate_votes_count, required this.is_checked});

  factory PollTopicCandidate.fromJson(Map<String, dynamic> json) {
    return PollTopicCandidate(
      id: json['id'],
      candidate_id: json['candidate_id'],
      candidate_user_id: json['candidate_user_id'],
      name: json['name'],
      age: json['age'],
      candidate_votes_count: json['candidate_votes_count'],
      is_checked: json['is_checked'],
    );
  }
  
 set set_is_checked(bool is_check) {
    is_checked=is_check;
  }
  

}
