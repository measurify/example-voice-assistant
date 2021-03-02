import 'dart:convert';

MeasurementModel measurementModelFromJson(String str) =>
    MeasurementModel.fromJson(json.decode(str));

String measurementModelToJson(MeasurementModel data) =>
    json.encode(data.toJson());

class MeasurementModel {
  final List<Doc> docs;
  final int totalDocs;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final dynamic prevPage;
  final int nextPage;

  MeasurementModel({
    this.docs,
    this.totalDocs,
    this.limit,
    this.totalPages,
    this.page,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  List<String> getAllSample() {
    List<String> samplesList = [];
    this.docs.forEach((doc) {
      doc.samples.forEach((sample) {
        sample.values.forEach((val) {
          samplesList.add(val);
        });
      });
    });
    return samplesList;
  }

  factory MeasurementModel.fromJson(Map<String, dynamic> json) =>
      MeasurementModel(
        docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class Doc {
  Doc({
    this.visibility,
    this.tags,
    this.id,
    this.thing,
    this.samples,
    this.feature,
    this.device,
    this.startDate,
    this.endDate,
  });

  String visibility;
  List<dynamic> tags;
  String id;
  String thing;
  List<Sample> samples;
  String feature;
  String device;
  DateTime startDate;
  DateTime endDate;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        visibility: json["visibility"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        id: json["_id"],
        thing: json["thing"],
        samples:
            List<Sample>.from(json["samples"].map((x) => Sample.fromJson(x))),
        feature: json["feature"],
        device: json["device"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "visibility": visibility,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "_id": id,
        "thing": thing,
        "samples": List<dynamic>.from(samples.map((x) => x.toJson())),
        "feature": feature,
        "device": device,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };
}

class Sample {
  Sample({
    this.values,
  });

  List<String> values;

  factory Sample.fromJson(Map<String, dynamic> json) => Sample(
        values: List<String>.from(json["values"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "values": List<dynamic>.from(values.map((x) => x)),
      };
}
