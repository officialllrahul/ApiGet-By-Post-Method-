
import 'dart:convert';

TaskDataModel taskDataModelFromJson(String str) => TaskDataModel.fromJson(json.decode(str));

String taskDataModelToJson(TaskDataModel data) => json.encode(data.toJson());

class TaskDataModel {
  String response;
  String message;
  List<Datum> data;
  dynamic error;

  TaskDataModel({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory TaskDataModel.fromJson(Map<String, dynamic> json) => TaskDataModel(
    response: json["response"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class Datum {
  int eventId;
  int userId;
  int speaker;
  int correntSpeaker;
  UserDetails userDetails;

  Datum({
    required this.eventId,
    required this.userId,
    required this.speaker,
    required this.correntSpeaker,
    required this.userDetails,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    eventId: json["event_id"],
    userId: json["user_id"],
    speaker: json["speaker"],
    correntSpeaker: json["corrent_speaker"],
    userDetails: UserDetails.fromJson(json["user_details"]),
  );

  Map<String, dynamic> toJson() => {
    "event_id": eventId,
    "user_id": userId,
    "speaker": speaker,
    "corrent_speaker": correntSpeaker,
    "user_details": userDetails.toJson(),
  };
}

class UserDetails {
  String? name;
  String email;
  Country? country;
  String? mobile;
  String? company;
  String? designation;
  String photo;
  About about;
  Gender? gender;
  dynamic type;
  int checking;

  UserDetails({
    required this.name,
    required this.email,
    required this.country,
    required this.mobile,
    required this.company,
    required this.designation,
    required this.photo,
    required this.about,
    required this.gender,
    required this.type,
    required this.checking,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    name: json["name"],
    email: json["email"],
    country: countryValues.map[json["country"]] ?? Country.EMPTY,
    mobile: json["mobile"],
    company: json["company"],
    designation: json["designation"],
    photo: json["photo"],
    about: aboutValues.map[json["about"]] ?? About.EMPTY,
    gender: genderValues.map[json["gender"]] ?? Gender.EMPTY,
    type: json["type"],
    checking: json["checking"],
  );


  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "country": countryValues.reverse[country],
    "mobile": mobile,
    "company": company,
    "designation": designation,
    "photo": photo,
    "about": aboutValues.reverse[about],
    "gender": genderValues.reverse[gender],
    "type": type,
    "checking": checking,
  };
}

enum About {
  A2_Z_1_TO10,
  EMPTY,
  SDCS
}

final aboutValues = EnumValues({
  "A2Z 1to10": About.A2_Z_1_TO10,
  "": About.EMPTY,
  "sdcs": About.SDCS
});

enum Country {
  BANGLADESH,
  EMPTY,
  INDIA,
  SRI_LANKA
}

final countryValues = EnumValues({
  "Bangladesh": Country.BANGLADESH,
  "": Country.EMPTY,
  "India": Country.INDIA,
  "Sri Lanka": Country.SRI_LANKA
});

enum Gender {
  EMPTY,
  FEMALE,
  MALE
}

final genderValues = EnumValues({
  "": Gender.EMPTY,
  "female": Gender.FEMALE,
  "male": Gender.MALE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
