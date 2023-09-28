import 'package:appflowy/generated/flowy_svgs.g.dart';
import 'package:appflowy/generated/locale_keys.g.dart';
import 'package:appflowy/workspace/application/appearance.dart';
import 'package:appflowy_backend/protobuf/flowy-user/date_time.pbenum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowy_infra_ui/flowy_infra_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_setting_entry_template.dart';

class TimeFormatSetting extends StatelessWidget {
  const TimeFormatSetting({
    super.key,
    required this.currentFormat,
  });

  final TimeFormatPB currentFormat;

  @override
  Widget build(BuildContext context) => ThemeSettingEntryTemplateWidget(
        label: LocaleKeys.settings_appearance_timeFormat_label.tr(),
        trailing: [
          ThemeValueDropDown(
            currentValue: _formatLabel(currentFormat),
            popupBuilder: (_) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _formatItem(context, TimeFormatPB.TwentyFourHour),
                _formatItem(context, TimeFormatPB.TwelveHour),
              ],
            ),
          ),
        ],
      );

  Widget _formatItem(BuildContext context, TimeFormatPB format) {
    return SizedBox(
      height: 32,
      child: FlowyButton(
        text: FlowyText.medium(_formatLabel(format)),
        rightIcon:
            currentFormat == format ? const FlowySvg(FlowySvgs.check_s) : null,
        onTap: () {
          if (currentFormat != format) {
            context.read<AppearanceSettingsCubit>().setTimeFormat(format);
          }
        },
      ),
    );
  }

  String _formatLabel(TimeFormatPB format) {
    switch (format) {
      case (TimeFormatPB.TwentyFourHour):
        return LocaleKeys.settings_appearance_timeFormat_twentyFourHour.tr();
      case (TimeFormatPB.TwelveHour):
        return LocaleKeys.settings_appearance_timeFormat_twelveHour.tr();
      default:
        return "";
    }
  }
}