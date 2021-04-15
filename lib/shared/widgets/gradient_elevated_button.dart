// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart = 2.8

import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:dipro/shared/widgets/gradient_button_style_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class GradientElevatedButton extends GradientButtonStyleButton {
  /// Create an GradientElevatedButton.
  ///
  /// The [autofocus] and [clipBehavior] arguments must not be null.
  const GradientElevatedButton({
    Key key,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    ButtonStyle style,
    FocusNode focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    @required Widget child,
    @required Gradient gradient,
  }) : super(
    key: key,
    onPressed: onPressed,
    onLongPress: onLongPress,
    style: style,
    focusNode: focusNode,
    autofocus: autofocus,
    clipBehavior: clipBehavior,
    child: child,
    gradient: gradient,
  );

  factory GradientElevatedButton.icon({
    Key key,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    ButtonStyle style,
    FocusNode focusNode,
    bool autofocus,
    Clip clipBehavior,
    @required Widget icon,
    @required Widget label,
    @required Gradient gradient,
  }) = _GradientElevatedButtonWithIcon;

  static ButtonStyle styleFrom({
    Color primary,
    Color onPrimary,
    Color onSurface,
    Color shadowColor,
    double elevation,
    TextStyle textStyle,
    EdgeInsetsGeometry padding,
    Size minimumSize,
    BorderSide side,
    OutlinedBorder shape,
    MouseCursor enabledMouseCursor,
    MouseCursor disabledMouseCursor,
    VisualDensity visualDensity,
    MaterialTapTargetSize tapTargetSize,
    Duration animationDuration,
    bool enableFeedback,
  }) {
    final MaterialStateProperty<Color> backgroundColor = (onSurface == null && primary == null)
      ? null
      : _ElevatedButtonDefaultBackground(primary, onSurface);
    final MaterialStateProperty<Color> foregroundColor = (onSurface == null && onPrimary == null)
      ? null
      : _ElevatedButtonDefaultForeground(onPrimary, onSurface);
    final MaterialStateProperty<Color> overlayColor = (onPrimary == null)
      ? null
      : _ElevatedButtonDefaultOverlay(onPrimary);
    final MaterialStateProperty<double> elevationValue = (elevation == null)
      ? null
      : _ElevatedButtonDefaultElevation(elevation);
    final MaterialStateProperty<MouseCursor> mouseCursor = (enabledMouseCursor == null && disabledMouseCursor == null)
      ? null
      : _ElevatedButtonDefaultMouseCursor(enabledMouseCursor, disabledMouseCursor);

    return ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(textStyle),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      overlayColor: overlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      elevation: elevationValue,
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
      side: ButtonStyleButton.allOrNull<BorderSide>(side),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      mouseCursor: mouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
    );
  }

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.symmetric(horizontal: 16),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.of(context)?.textScaleFactor ?? 1,
    );

    return styleFrom(
      primary: colorScheme.primary,
      onPrimary: colorScheme.onPrimary,
      onSurface: colorScheme.onSurface,
      shadowColor: theme.shadowColor,
      elevation: 2,
      textStyle: theme.textTheme.button,
      padding: scaledPadding,
      minimumSize: const Size(64, 36),
      side: BorderSide.none,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
      enabledMouseCursor: SystemMouseCursors.click,
      disabledMouseCursor: SystemMouseCursors.forbidden,
      visualDensity: theme.visualDensity,
      tapTargetSize: theme.materialTapTargetSize,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
    );
  }

  /// Returns the [ElevatedButtonThemeData.style] of the closest
  /// [ElevatedButtonTheme] ancestor.
  @override
  ButtonStyle themeStyleOf(BuildContext context) {
    return ElevatedButtonTheme.of(context)?.style;
  }
}

@immutable
class _ElevatedButtonDefaultBackground extends MaterialStateProperty<Color> with Diagnosticable {
  _ElevatedButtonDefaultBackground(this.primary, this.onSurface);

  final Color primary;
  final Color onSurface;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled))
      return onSurface?.withOpacity(0.12);
    return primary;
  }
}

@immutable
class _ElevatedButtonDefaultForeground extends MaterialStateProperty<Color> with Diagnosticable {
  _ElevatedButtonDefaultForeground(this.onPrimary, this.onSurface);

  final Color onPrimary;
  final Color onSurface;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled))
      return onSurface?.withOpacity(0.38);
    return onPrimary;
  }
}

@immutable
class _ElevatedButtonDefaultOverlay extends MaterialStateProperty<Color> with Diagnosticable {
  _ElevatedButtonDefaultOverlay(this.onPrimary);

  final Color onPrimary;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered))
      return onPrimary?.withOpacity(0.08);
    if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed))
      return onPrimary?.withOpacity(0.24);
    return null;
  }
}

@immutable
class _ElevatedButtonDefaultElevation extends MaterialStateProperty<double> with Diagnosticable {
  _ElevatedButtonDefaultElevation(this.elevation);

  final double elevation;

  @override
  double resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled))
      return 0;
    if (states.contains(MaterialState.hovered))
      return elevation + 2;
    if (states.contains(MaterialState.focused))
      return elevation + 2;
    if (states.contains(MaterialState.pressed))
      return elevation + 6;
    return elevation;
  }
}

@immutable
class _ElevatedButtonDefaultMouseCursor extends MaterialStateProperty<MouseCursor> with Diagnosticable {
  _ElevatedButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

  final MouseCursor enabledCursor;
  final MouseCursor disabledCursor;

  @override
  MouseCursor resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled))
      return disabledCursor;
    return enabledCursor;
  }
}

class _GradientElevatedButtonWithIcon extends GradientElevatedButton {
  _GradientElevatedButtonWithIcon({
    Key key,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    ButtonStyle style,
    FocusNode focusNode,
    bool autofocus,
    Clip clipBehavior,
    @required Widget icon,
    @required Widget label,
    @required Gradient gradient,
  }) : assert(icon != null),
       assert(label != null),
       super(
         key: key,
         onPressed: onPressed,
         onLongPress: onLongPress,
         style: style,
         focusNode: focusNode,
         autofocus: autofocus ?? false,
         clipBehavior: clipBehavior ?? Clip.none,
         child: _GradientElevatedButtonWithIconChild(icon: icon, label: label),
         gradient: gradient
      );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsetsDirectional.fromSTEB(8, 0, 4, 0),
      MediaQuery.of(context,)?.textScaleFactor ?? 1,
    );
    return super.defaultStyleOf(context).copyWith(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(scaledPadding)
    );
  }
}

class _GradientElevatedButtonWithIconChild extends StatelessWidget {
  const _GradientElevatedButtonWithIconChild({ Key key, this.label, this.icon }) : super(key: key);

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context,)?.textScaleFactor ?? 1;
    final double gap = scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1));
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), label],
    );
  }
}
