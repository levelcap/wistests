const REWATCH_PERCENTAGE = 25.0;

class CustomVideoPlayer {
  constructor(player) {
    this.watchedSecondsMap;
    this.lastSecondStarted = 0.0;
    this.rewatchCounter = 0;
    this.rewatchPercent = 0.0;
    this.mousedown = false;
    this.progress = player.querySelector('.progress');
    this.progressBar = player.querySelector('.progress_filled');
    this.durationText = player.querySelector('.current_time');
    this.video = player.querySelector('.viewer');

    this.video.addEventListener('click', this.togglePlay.bind(this));
    this.video.addEventListener('timeupdate', this.handleProgress.bind(this));
    this.video.addEventListener('canplay', this.initializeWatchStatistics.bind(this));

    var that = this;
    var boundScrub = that.scrub.bind(that);
    this.progress.addEventListener('click', boundScrub);
    this.progress.addEventListener('mousemove', (e) => that.mousedown && boundScrub(e));
    this.progress.addEventListener('mousedown', () => that.mousedown = true);
    this.progress.addEventListener('mouseup', () => that.mousedown = false);
  }

  initializeWatchStatistics() {
    if (!this.watchedSecondsMap) {
      this.watchedSecondsMap = new Map();
      var durationInSeconds = Math.ceil(this.video.duration);
      for (let x = 0; x < durationInSeconds; x++) {
        this.watchedSecondsMap.set(x, 0);
      }
    }
  }

  checkRewatchProgress() {
    this.rewatchPercent = (this.rewatchCounter / this.video.duration) * 100.0;
    if (this.rewatchPercent >= REWATCH_PERCENTAGE) {
      console.log('More than ' + REWATCH_PERCENTAGE + '% of ' + this.video.src + ' has been rewatched');
    }
  }

  incrementSecondWatches(second) {
    let watchTimes = this.watchedSecondsMap.get(second) + 1;
    this.watchedSecondsMap.set(second, watchTimes);
    // Add to rewatch counter only on the second watch
    if (watchTimes == 2) {
      this.rewatchCounter++;
    }
    // Only need to check/log rewatch percentage if we haven't already reached 25%
    if (this.rewatchPercent <= REWATCH_PERCENTAGE) {
      this.checkRewatchProgress();
    }
  }

  togglePlay() {
    const method = this.video.paused ? 'play' : 'pause';
    this.video[method]();
  }

  // Displays current video time, broken into <minutes>:<seconds>
  updateCurrentTimeDisplay() {
    const minutes = Math.floor(this.video.currentTime / 60);
    let seconds = Math.floor(this.video.currentTime);
    // Pad a leading 0 for display purposes
    if (seconds < 10) {
      seconds = "0" + seconds;
    }
    this.durationText.textContent = minutes + ":" + seconds;
  }

  handleProgress() {
    const watched = this.video.currentTime - this.lastSecondStarted;
    if (watched > 1) {
      this.lastSecondStarted = Math.floor(this.video.currentTime);
      this.incrementSecondWatches(Math.floor(this.lastSecondStarted));
    }
    const percent = (this.video.currentTime / this.video.duration) * 100;
    this.progressBar.style.flexBasis = `${percent}%`;
    this.updateCurrentTimeDisplay();
  }

  scrub(e) {
    const scrubTime = (e.offsetX / this.progress.offsetWidth) * this.video.duration;
    this.video.currentTime = scrubTime;
    // Set lastSecondStarted to new time to prevent negative comparison values
    this.lastSecondStarted = Math.floor(this.video.currentTime);
    this.updateCurrentTimeDisplay();
  }
}

const players = document.querySelectorAll('.player');

players.forEach((player) => {
  const customVideo = new CustomVideoPlayer(player);
});
