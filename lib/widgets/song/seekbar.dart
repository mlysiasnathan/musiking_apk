import 'dart:math';

import 'package:flutter/material.dart';

class SeekBarData {
  final Duration position;
  final Duration duration;

  SeekBarData(this.position, this.duration);
}

class SeekBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangedEnd;

  const SeekBar(
      {super.key,
      required this.position,
      required this.duration,
      this.onChanged,
      this.onChangedEnd});
  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '00:00';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Text(
          _formatDuration(widget.position),
          style: TextStyle(fontSize: 10, color: theme.colorScheme.background),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 7,
              thumbShape: const RoundSliderThumbShape(
                disabledThumbRadius: 14,
                enabledThumbRadius: 0,
                elevation: 5,
              ),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 9),
              inactiveTrackColor: theme.colorScheme.background.withOpacity(0.3),
              activeTrackColor: theme.colorScheme.background,
              thumbColor: theme.colorScheme.background,
              overlayColor: theme.colorScheme.background,
            ),
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(
                _dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble(),
              ),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(
                    Duration(
                      milliseconds: value.round(),
                    ),
                  );
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangedEnd != null) {
                  widget.onChangedEnd!(
                    Duration(
                      milliseconds: value.round(),
                    ),
                  );
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        Text(
          _formatDuration(widget.duration),
          style: TextStyle(fontSize: 10, color: theme.colorScheme.background),
        ),
      ],
    );
  }
}
