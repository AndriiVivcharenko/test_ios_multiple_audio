@JS()
library audio_function_js;

import 'package:js/js.dart';

@JS()
class WebAudioAPISound {
  external WebAudioAPISound(String url, Options options);

  external void play();

  external void stop();

  external void getVolume();

  external void setVolume(double volume);

  external void translateVolume(double volume, bool inverse);

  external void makeSource(dynamic buffer);
}

@JS()
@anonymous
class Options {
  external bool get loop;

  // Must have an unnamed factory constructor with named arguments.
  external factory Options({bool loop});
}
