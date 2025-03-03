// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppConfigImpl _$$AppConfigImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigImpl(
      appVersion: json['appVersion'] as String,
      isForceUpdate: json['isForceUpdate'] as bool,
      isMaintenance: json['isMaintenance'] as bool,
      maintenanceMessage: json['maintenanceMessage'] as String?,
    );

Map<String, dynamic> _$$AppConfigImplToJson(_$AppConfigImpl instance) =>
    <String, dynamic>{
      'appVersion': instance.appVersion,
      'isForceUpdate': instance.isForceUpdate,
      'isMaintenance': instance.isMaintenance,
      'maintenanceMessage': instance.maintenanceMessage,
    };
