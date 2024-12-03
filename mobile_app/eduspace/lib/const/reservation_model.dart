// reservation_model.dart
class ReservationModel {
  final String name;
  final String email;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String room;
  final String people;
  final String reservationType;

  ReservationModel({
    required this.name,
    required this.email,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.people,
    required this.reservationType,
  });

  // To convert a ReservationModel into a Map (for sending to API)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
      'room': room,
      'people': people,
      'reservationType': reservationType,
    };
  }

  // Factory method to create a ReservationModel from a Map
  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      name: map['name'],
      email: map['email'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      room: map['room'],
      people: map['people'],
      reservationType: map['reservationType'],
    );
  }
}
