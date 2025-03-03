import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/app_config.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.initial() = _Initial;
  const factory SplashState.loading() = _Loading;
  const factory SplashState.configured(AppConfig config) = _Configured;
  const factory SplashState.error(String message) = _Error;
  const factory SplashState.navigateToAuth() = _NavigateToAuth;
  const factory SplashState.navigateToHome() = _NavigateToHome;
}