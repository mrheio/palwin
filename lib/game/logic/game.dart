import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/database.dart';

class Game extends Serializable<Game> {
  final String name;
  final int teamSize;
  final String iconPath;
  final File? icon;
  final String? downloadURL;

  Game({
    String? id,
    required this.name,
    required this.teamSize,
    this.iconPath = '',
    this.icon,
    this.downloadURL,
    DateTime? createdAt,
  }) : super(id: id ?? name.replaceAll(' ', '_'), createdAt: createdAt);

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as String,
      name: json['name'] as String,
      teamSize: json['teamSize'] as int,
      iconPath: json['iconPath'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
    );
  }

  factory Game.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Game.fromJson(data);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'teamSize': teamSize,
      'iconPath': iconPath,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object?> get props => [id, name, teamSize, iconPath, icon, downloadURL];

  @override
  Game copyWith({
    String? id,
    String? name,
    int? teamSize,
    String? iconPath,
    File? icon,
    String? downloadURL,
    DateTime? createdAt,
  }) {
    return Game(
      id: id ?? this.id,
      name: name ?? this.name,
      teamSize: teamSize ?? this.teamSize,
      iconPath: iconPath ?? this.iconPath,
      icon: icon ?? this.icon,
      downloadURL: downloadURL ?? this.downloadURL,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static String toId(String name) => name.replaceAll(' ', '_');
  static String toName(String id) => id.replaceAll('_', ' ');
}
