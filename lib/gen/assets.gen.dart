/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $ResGen {
  const $ResGen();

  /// Directory path: res/images
  $ResImagesGen get images => const $ResImagesGen();
}

class $ResImagesGen {
  const $ResImagesGen();

  /// Directory path: res/images/png
  $ResImagesPngGen get png => const $ResImagesPngGen();

  /// Directory path: res/images/svg
  $ResImagesSvgGen get svg => const $ResImagesSvgGen();
}

class $ResImagesPngGen {
  const $ResImagesPngGen();

  /// File path: res/images/png/ic_get_started_bg.png
  AssetGenImage get icGetStartedBg =>
      const AssetGenImage('res/images/png/ic_get_started_bg.png');

  /// File path: res/images/png/ic_google_auth_icon.png
  AssetGenImage get icGoogleAuthIcon =>
      const AssetGenImage('res/images/png/ic_google_auth_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [icGetStartedBg, icGoogleAuthIcon];
}

class $ResImagesSvgGen {
  const $ResImagesSvgGen();

  /// File path: res/images/svg/ic_apple_auth_icno.svg
  SvgGenImage get icAppleAuthIcno =>
      const SvgGenImage('res/images/svg/ic_apple_auth_icno.svg');

  /// File path: res/images/svg/ic_facebook_auth_icon.svg
  SvgGenImage get icFacebookAuthIcon =>
      const SvgGenImage('res/images/svg/ic_facebook_auth_icon.svg');

  /// File path: res/images/svg/ic_horizontal_app_logo.svg
  SvgGenImage get icHorizontalAppLogo =>
      const SvgGenImage('res/images/svg/ic_horizontal_app_logo.svg');

  /// File path: res/images/svg/ic_lock.svg
  SvgGenImage get icLock => const SvgGenImage('res/images/svg/ic_lock.svg');

  /// File path: res/images/svg/ic_mail_icon.svg
  SvgGenImage get icMailIcon =>
      const SvgGenImage('res/images/svg/ic_mail_icon.svg');

  /// File path: res/images/svg/ic_on_boarding_1.svg
  SvgGenImage get icOnBoarding1 =>
      const SvgGenImage('res/images/svg/ic_on_boarding_1.svg');

  /// File path: res/images/svg/ic_on_boarding_2.svg
  SvgGenImage get icOnBoarding2 =>
      const SvgGenImage('res/images/svg/ic_on_boarding_2.svg');

  /// File path: res/images/svg/ic_on_boarding_3.svg
  SvgGenImage get icOnBoarding3 =>
      const SvgGenImage('res/images/svg/ic_on_boarding_3.svg');

  /// File path: res/images/svg/ic_password_eye.svg
  SvgGenImage get icPasswordEye =>
      const SvgGenImage('res/images/svg/ic_password_eye.svg');

  /// File path: res/images/svg/ic_user.svg
  SvgGenImage get icUser => const SvgGenImage('res/images/svg/ic_user.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    icAppleAuthIcno,
    icFacebookAuthIcon,
    icHorizontalAppLogo,
    icLock,
    icMailIcon,
    icOnBoarding1,
    icOnBoarding2,
    icOnBoarding3,
    icPasswordEye,
    icUser,
  ];
}

class Assets {
  const Assets._();

  static const $ResGen res = $ResGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
