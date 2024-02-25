class TimeSlotResponse {
  bool? status;
  List<TimeSlots>? timeSlots;
  String? message;

  TimeSlotResponse({this.status, this.timeSlots, this.message});

  TimeSlotResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['time_slots'] != null) {
      timeSlots = <TimeSlots>[];
      json['time_slots'].forEach((v) {
        timeSlots!.add(TimeSlots.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class TimeSlots {
  int? id;
  String? from;
  String? to;

  TimeSlots({this.id, this.from, this.to});

  TimeSlots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
  }
}
