import 'package:flutter/material.dart';
import 'package:greycells/constants/strings.dart';

class PersonalityType {
  final String _title;
  final String _description;
  final String _initialCharacter;
  final Color _color;

  const PersonalityType._internal(
      this._title, this._initialCharacter, this._description, this._color);

  String title() => _title;

  String description() => _description;

  String initials() => _initialCharacter;

  Color color() => _color;

  static const EXTROVERT = const PersonalityType._internal(
      "Extroverts", "E", Strings.extrovertDescription, Color(0xFF2D8FF4));
  static const INTROVERT = const PersonalityType._internal(
      "Introverts", "I", Strings.introvertDescription, Color(0xFF175E7D));
  static const SENSOR = const PersonalityType._internal(
      "Sensors", "S", Strings.sensorDescription, Color(0xFF36B162));
  static const INTUITIVE = const PersonalityType._internal(
      "Intuitives", "N", Strings.intuitiveDescription, Color(0xFF815EC3));
  static const THINKER = const PersonalityType._internal(
      "Thinkers", "T", Strings.thinkerDescription, Color(0xFFF03A36));
  static const FEELER = const PersonalityType._internal(
      "Feelers", "F", Strings.feelerDescription, Color(0xFFF361CA));
  static const JUDGER = const PersonalityType._internal(
      "Judgers", "J", Strings.judgerDescription, Color(0xFFFBC140));
  static const PERCEIVER = const PersonalityType._internal(
      "Perceivers", "P", Strings.perceiverDescription, Color(0xFFF5732C));

  static List<PersonalityType> values = [
    EXTROVERT,
    INTROVERT,
    SENSOR,
    INTUITIVE,
    THINKER,
    FEELER,
    JUDGER,
    PERCEIVER
  ];
}
