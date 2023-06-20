
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soundpool/soundpool.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // final audio = AudioPlayer();
  // final audio2 = AudioPlayer();

  final audio = AudioPlayer();
  final audio2 = AudioPlayer();

  final soundpool = Soundpool.fromOptions();

  bool _initDone = true;

  int id1 = 0;
  int id1Playing = 0;

  int id2 = 0;
  int id2Playing = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    final url1 =
        "https://firebasestorage.googleapis.com/v0/b/chat-6f260.appspot.com/o/music%2FhighIntensity%2Fhighintensity10__BPM148.mp3?alt=media&token=2bb8bea5-e087-4aee-82aa-5671f257ebe8";
    final url2 =
        "https://firebasestorage.googleapis.com/v0/b/chat-6f260.appspot.com/o/music%2FhighIntensity%2Fhighintensity14__BPM130.mp3?alt=media&token=b861da7b-a23a-4027-84e3-15787596870d";


    soundpool.loadUri(url1).then((value) => id1 = value);
    soundpool.loadUri(url2).then((value) => id2 = value);

    // Future.delayed(Duration(seconds: 3), () {
    //   _playAudio1();
    //   _playAudio2();
    // });
  }

  void _init() async {

    _playAudio1();
    _playAudio2();
    return;

    _initDone = false;



    setState(() {});
    final url1 =
        "https://firebasestorage.googleapis.com/v0/b/chat-6f260.appspot.com/o/music%2FhighIntensity%2Fhighintensity10__BPM148.mp3?alt=media&token=2bb8bea5-e087-4aee-82aa-5671f257ebe8";
    final url2 =
        "https://firebasestorage.googleapis.com/v0/b/chat-6f260.appspot.com/o/music%2FhighIntensity%2Fhighintensity14__BPM130.mp3?alt=media&token=b861da7b-a23a-4027-84e3-15787596870d";

    await audio.setSource(UrlSource(url1));
    print("audio setSource");
    await audio2.setSource(UrlSource(url2));
    print("audio2 setSource");

    print("audio resume");
    await audio.resume();
    print("audio pause");
    await audio.pause();

    print("audio2 resume");
    await audio2.resume();
    print("audio2 pause");
    await audio2.pause();

    _initDone = true;
    setState(() {});

    print("delayed");
    Future.delayed(Duration(seconds: 5), () {
      print("playAudio1");
      _playAudio1();
      print("playAudio2");
      _playAudio2();
    });
  }

  void _playAudio1() async {
    // final file = await http.get(Uri.parse(url));

    // final file = await DefaultAssetBundle.of(context).load("assets/1.mp3");
    //
    // final blob = Blob(file.buffer.asUint8List());
    //
    // print(blob.size);

    id1Playing = await soundpool.play(id1);

    // final url1 =
    //     "https://firebasestorage.googleapis.com/v0/b/chat-6f260.appspot.com/o/music%2FlowIntensity%2Flowintensity10__BPM72.mp3?alt=media&token=a2a81764-32aa-448a-9745-eb2aab73b5fc";
    //
    // audio.play(UrlSource(url1));

    // await audio.play(UrlSource(Url.createObjectUrlFromBlob(blob)));
  }

  void _playAudio2() async {
    // audio2.play(UrlSource(url));

    // final file = await http.get(Uri.parse(url));

    // final file = await DefaultAssetBundle.of(context).load("assets/2.mp3");
    //
    // final blob = Blob(file.buffer.asUint8List());
    //
    // print(blob.size);

    // final blob = Blob(file.bodyBytes);

    id2Playing = await soundpool.play(id2);


    // final url2 =
    //     "https://firebasestorage.googleapis.com/v0/b/chat-6f260.appspot.com/o/music%2FlowIntensity%2Flowintensity14__BPM60.mp3?alt=media&token=bbf3fa19-12c7-48d7-9bb1-8c2edbf19e66";

    // audio2.play(UrlSource(url2));

    // print(file.bodyBytes);

    // await audio2.play(UrlSource(Url.createObjectUrlFromBlob(blob)));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        actions: [],
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => _initDone ? Colors.blue : Colors.grey)),
                onPressed: () {
                  if (!_initDone) return;

                  _init();
                },
                child: Text("Init")),
            ElevatedButton(
                onPressed: () async {
                  _playAudio1();
                },
                child: Text("Play 1")),
            ElevatedButton(
                onPressed: () {
                  audio.pause();
                  soundpool.pause(id1Playing);
                },
                child: Text("Pause 1")),
            ElevatedButton(
                onPressed: () async {
                  _playAudio2();
                },
                child: Text("Play 2")),
            ElevatedButton(onPressed: () {
              audio2.pause();
              soundpool.pause(id2Playing);
            }, child: Text("Pause 2")),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
