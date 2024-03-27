import 'dart:convert';

class ChatModel {
  final String role;

  final List<ChatPartModel> parts;

  ChatModel({required this.parts, required this.role,});

  toMap() {
    return {
      'role': role,
      'parts': parts.map((part) => part.toMap()).toList(),
    };
  }
}

class ChatPartModel {
  final String text;
  ChatPartModel({required this.text});

  toMap() {
    return {
      'text': text,
    };
  }
}

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  List<Content> contents;
  GenerationConfig generationConfig;
  List<SafetySetting> safetySettings;

  Welcome({
    required this.contents,
    required this.generationConfig,
    required this.safetySettings,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        contents: List<Content>.from(
            json["contents"].map((x) => Content.fromJson(x))),
        generationConfig: GenerationConfig.fromJson(json["generationConfig"]),
        safetySettings: List<SafetySetting>.from(
            json["safetySettings"].map((x) => SafetySetting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
        "generationConfig": generationConfig.toJson(),
        "safetySettings":
            List<dynamic>.from(safetySettings.map((x) => x.toJson())),
      };
}

class Content {
  String role;
  List<Part> parts;

  Content({
    required this.role,
    required this.parts,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        role: json["role"],
        parts: List<Part>.from(json["parts"].map((x) => Part.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
      };
}

class Part {
  String text;

  Part({
    required this.text,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}

class GenerationConfig {
  double temperature;
  int topK;
  int topP;
  int maxOutputTokens;
  List<dynamic> stopSequences;

  GenerationConfig({
    required this.temperature,
    required this.topK,
    required this.topP,
    required this.maxOutputTokens,
    required this.stopSequences,
  });

  factory GenerationConfig.fromJson(Map<String, dynamic> json) =>
      GenerationConfig(
        temperature: json["temperature"]?.toDouble(),
        topK: json["topK"],
        topP: json["topP"],
        maxOutputTokens: json["maxOutputTokens"],
        stopSequences: List<dynamic>.from(json["stopSequences"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "topK": topK,
        "topP": topP,
        "maxOutputTokens": maxOutputTokens,
        "stopSequences": List<dynamic>.from(stopSequences.map((x) => x)),
      };
}

class SafetySetting {
  String category;
  String threshold;

  SafetySetting({
    required this.category,
    required this.threshold,
  });

  factory SafetySetting.fromJson(Map<String, dynamic> json) => SafetySetting(
        category: json["category"],
        threshold: json["threshold"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "threshold": threshold,
      };
}
