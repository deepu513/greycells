import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/app_theme.dart';
import 'package:greycells/bloc/report/reports_bloc.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';
import 'package:greycells/extensions.dart';

class PatientReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assessment Reports',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87, fontWeight: FontWeight.w400),
        ),
        elevation: 4.0,
        brightness: Brightness.light,
      ),
      body: SafeArea(
          child: BlocProvider(
        create: (context) => ReportsBloc(),
        child: AllReportsSection(),
      )),
    );
  }
}

class AllReportsSection extends StatefulWidget {
  @override
  _AllReportsSectionState createState() => _AllReportsSectionState();
}

class _AllReportsSectionState extends State<AllReportsSection> {
  @override
  void initState() {
    super.initState();
    _loadAllReports();
  }

  _loadAllReports() {
    BlocProvider.of<ReportsBloc>(context).add(LoadAllReports());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportsBloc, ReportsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ReportsLoading) return CenteredCircularLoadingIndicator();
        if (state is ReportsLoaded)
          return ScrollConfiguration(
            behavior: NoGlowScrollBehaviour(),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    BlocProvider.of<ReportsBloc>(context)
                        .add(DownloadReport(state.reports[index].fileName));
                  },
                  leading: RichText(
                    text: TextSpan(
                      text: "${index + 1}",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.purple, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: "${getDayOfMonthSuffix(index + 1)}",
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: Colors.purple,
                              ),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    "Assessment Report",
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: "Created on ",
                      style: Theme.of(context).textTheme.caption.copyWith(),
                      children: [
                        TextSpan(
                          text:
                              " ${state.reports[index].createdDate.asDate().readableDate()}",
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: Colors.black87,
                              ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_circle_down_rounded,
                    color: AppTheme.iconColor,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: state.reports.length,
            ),
          );
        if (state is ReportsEmpty) return EmptyState();
        if (state is ReportsError)
          return ErrorWithRetry(
            onRetryPressed: () {
              _loadAllReports();
            },
          );
        return Container();
      },
    );
  }

  String getDayOfMonthSuffix(final int n) {
    if (n >= 11 && n <= 13) {
      return "th";
    }
    switch (n % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }
}
