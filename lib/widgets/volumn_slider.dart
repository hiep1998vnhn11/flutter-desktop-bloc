import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VolumeSlider extends StatefulWidget {
  final Display display;
  final Color? sliderActiveColor;
  final Color? sliderInActiveColor;

  const VolumeSlider({
    Key? key,
    this.sliderActiveColor,
    this.sliderInActiveColor,
    required this.display,
  }) : super(key: key);

  @override
  _VolumeSliderState createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double initVal = .1;
  final MethodChannel _channel = const MethodChannel('freekit.fr/volume');

  Future<void> changeVolume(double volume) async {
    try {
      return _channel.invokeMethod('changeVolume', <String, dynamic>{
        'volume': volume,
      });
    } on PlatformException catch (e) {
      throw 'Unable to change volume : ${e.message}';
    }
  }

  Future<MaxVolume> getMaxVolume() async {
    try {
      //var val = await _channel.invokeMethod('getMaxVolume');
      var val = 1.0;
      return MaxVolume(val.toDouble());
    } on PlatformException catch (e) {
      throw 'Unable to get max volume : ${e.message}';
    }
  }

  Future<MinVolume> getMinVolume() async {
    try {
      // var val = await _channel.invokeMethod('getMinVolume');
      var val = 0.0;
      return MinVolume(val.toDouble());
    } on PlatformException catch (e) {
      throw 'Unable to get max volume e : ${e.message}';
    }
  }

  _buildVerticalContainer(maxVol, minVol) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          CupertinoIcons.volume_mute,
          size: 25.0,
          color: Colors.black,
        ),
        SizedBox(
          height: 125,
          child: Transform(
            alignment: FractionalOffset.center,
            // Rotate sliders by 90 degrees
            transform: Matrix4.identity()..rotateZ(90 * 3.1415927 / 180),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 175,
                  child: Slider(
                    activeColor: widget.sliderActiveColor ?? Colors.black,
                    inactiveColor: widget.sliderInActiveColor ?? Colors.grey,
                    value: initVal,
                    divisions: 50,
                    max: maxVol.value,
                    min: minVol.value,
                    onChanged: (value) {
                      changeVolume(value);
                      setState(() => initVal = value);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        const Icon(
          CupertinoIcons.volume_up,
          size: 25.0,
          color: Colors.black,
        ),
      ],
    );
  }

  _buildHorizontalContainer(maxVol, minVol) {
    return Slider(
      activeColor: widget.sliderActiveColor ?? Colors.black,
      inactiveColor: widget.sliderInActiveColor ?? Colors.grey,
      value: initVal,
      max: 1,
      min: 0,
      onChanged: (value) {
        // changeVolume(value);
        setState(() => initVal = value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.display == Display.HORIZONTAL) {
      return _buildHorizontalContainer(1, 0);
    } else {
      return _buildVerticalContainer(1, 0);
    }
  }
}

enum Display { HORIZONTAL, VERTICAL }

class MinVolume {
  double value;
  MinVolume(this.value);
}

class MaxVolume {
  double value;
  MaxVolume(this.value);
}
