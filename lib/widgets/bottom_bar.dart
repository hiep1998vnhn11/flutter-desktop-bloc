import 'package:flutter/material.dart';
import './app_icon_button.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  bool playing = true;
  bool shuffle = false;
  int repeat = 0;
  double volumn = 50;

  void _onRepeatClick() {
    setState(() {
      repeat++;
      if (repeat > 2) {
        repeat = 0;
      }
    });
  }

  void _onVolumnChange(double value) {
    setState(() {
      volumn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 240,
        ),
        Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  AppIconButton(
                    icon: Icons.shuffle_rounded,
                    active: shuffle,
                    onPress: () {
                      setState(() {
                        shuffle = !shuffle;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {},
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).bottomAppBarColor,
                    ),
                    child: IconButton(
                      icon: playing
                          ? const Icon(Icons.play_arrow)
                          : const Icon(Icons.stop),
                      onPressed: () {
                        setState(() {
                          playing = !playing;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {},
                  ),
                  AppIconButton(
                    active: repeat > 0,
                    icon: repeat == 2
                        ? Icons.repeat_one_rounded
                        : Icons.repeat_rounded,
                    onPress: _onRepeatClick,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('0:00'),
                Text('0:00'),
                Text('0:00'),
              ],
            )
          ],
        ),
        SizedBox(
          width: 240,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const AppIconButton(
                icon: Icons.queue_music_rounded,
                active: true,
              ),
              const AppIconButton(
                icon: Icons.queue_music_rounded,
                active: true,
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  inactiveTrackColor: Theme.of(context).bottomAppBarColor,
                  thumbColor: Theme.of(context).colorScheme.secondary,
                  overlayColor: Theme.of(context).colorScheme.secondary,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 8,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 5,
                  ),
                  trackHeight: 5,
                ),
                child: Slider(
                  min: 0,
                  max: 100,
                  value: volumn,
                  onChanged: _onVolumnChange,
                  divisions: 100,
                ),
              ),
              // const SizedBox(
              //   width: 10,
              // ),
            ],
          ),
        )
      ],
    );
  }
}
