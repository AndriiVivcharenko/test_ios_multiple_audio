try {
    window.AudioContext = window.AudioContext || window.webkitAudioContext;
    window.audioContext = new window.AudioContext();
    console.log("Web Audio API initialized");
} catch (e) {
    console.log("No Web Audio API support");
}

/*
* WebAudioAPISoundManager Class
*/
WebAudioAPISoundManager = class {

    constructor(context) {
        this.context = context;
        this.bufferList = {};
        this.playingSounds = {};
    }

    addSound(url) {
        // Load buffer asynchronously
        var request = new XMLHttpRequest();
        request.open("GET", url, true);
        request.responseType = "arraybuffer";

        var self = this;

        request.onload = function () {
            // Asynchronously decode the audio file data in request.response
            self.context.decodeAudioData(
                request.response,

                function (buffer) {
                    if (!buffer) {
                        alert('error decoding file data: ' + url);
                        return;
                    }
                    self.bufferList[url] = buffer;
                });
        };

        request.onerror = function () {
            alert('BufferLoader: XHR error');
        };

        request.send();
    }

    stopSoundWithUrl(url) {
        if(this.playingSounds.hasOwnProperty(url)){
            for(var i in this.playingSounds[url]){
                if(this.playingSounds[url].hasOwnProperty(i))
                    this.playingSounds[url][i].stop(0);
            }
        }
    }
}

/*
* WebAudioAPISound Class
*/
window.WebAudioAPISound = class {

    constructor(url, options) {
        this.settings = {
            loop: false
        };
    
        for(var i in options){
            if(options.hasOwnProperty(i))
                this.settings[i] = options[i];
        }
    
        this.url = url;
        this.volume = 50;
        window.webAudioAPISoundManager = window.webAudioAPISoundManager || new WebAudioAPISoundManager(window.audioContext);
        this.manager = window.webAudioAPISoundManager;
        this.manager.addSound(this.url);
    }

    play() {
        var buffer = this.manager.bufferList[this.url];
        // Only play if it's loaded yet
        if (typeof buffer !== "undefined") {
            var source = this.makeSource(buffer);
            source.loop = this.settings.loop;
            source.start(0);

            if(!this.manager.playingSounds.hasOwnProperty(this.url))
                this.manager.playingSounds[this.url] = [];
            this.manager.playingSounds[this.url].push(source);
        }
    }

    stop() {
        this.manager.stopSoundWithUrl(this.url);
    }

    getVolume() {
        return this.translateVolume(this.volume, true);
    }

    // Expect to receive in range 0-100
    setVolume(volume) {
        this.volume = this.translateVolume(volume);
    }

    translateVolume(volume, inverse) {
        return inverse ? volume * 100 : volume / 100;
    }

    makeSource(buffer) {
        var source = this.manager.context.createBufferSource();
        var gainNode = this.manager.context.createGain ? this.manager.context.createGain() : this.manager.context.createGainNode();
        gainNode.gain.value = this.volume;
        source.buffer = buffer;
        source.connect(gainNode);
        gainNode.connect(this.manager.context.destination);
        return source;
    }
}