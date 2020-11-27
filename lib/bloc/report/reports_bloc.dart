import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/models/reports/report.dart';
import 'package:greycells/repository/reports_repository.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:greycells/extensions.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  SettingsRepository _settingsRepository;
  ReportsRepository _reportsRepository;

  ReportsBloc() : super(ReportsInitial()) {
    _reportsRepository = ReportsRepository();
  }

  @override
  Stream<ReportsState> mapEventToState(ReportsEvent event) async* {
    if (event is LoadAllReports) {
      yield ReportsLoading();
      try {
        _settingsRepository = await SettingsRepository.getInstance();

        List<Report> reports = await _reportsRepository.getReportsForPatient(
            _settingsRepository.get(SettingKey.KEY_PATIENT_ID));

        if (reports != null) {
          if (reports.isEmpty) {
            yield ReportsEmpty();
          } else if (reports.isNotEmpty) {
            yield ReportsLoaded(reports);
          }
        } else
          yield ReportsError();
      } catch (e) {
        debugPrint(e);
        yield ReportsError();
      }
    }

    if (event is LoadReportsForPatient) {
      yield ReportsLoading();
      try {
        List<Report> reports =
            await _reportsRepository.getReportsForPatient(event.patientId);

        if (reports != null) {
          if (reports.isEmpty) {
            yield ReportsEmpty();
          } else if (reports.isNotEmpty) {
            yield ReportsLoaded(reports);
          }
        } else
          yield ReportsError();
      } catch (e) {
        debugPrint(e);
        yield ReportsError();
      }
    }

    if (event is DownloadReport) {
      bool permissionGranted = await _checkPermission();

      if (permissionGranted) {
        await FlutterDownloader.enqueue(
            url: event.fileName.withBaseUrlForReport(),
            savedDir: (await _findLocalPath()),
            showNotification: true,
            openFileFromNotification: true);
      }
    }
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
}
