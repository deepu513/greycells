part of 'decider_bloc.dart';

@immutable
abstract class DeciderState {}

class DeciderInitial extends DeciderState {}

class NextPageDecided extends DeciderState {
  final String routeName;

  NextPageDecided(this.routeName);
}

class NextPageDeciding extends DeciderState {}

class DeciderError extends DeciderState {}
