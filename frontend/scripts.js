const player = document.querySelector('.player');
const video = player.querySelector('.viewer');
const progress = player.querySelector('.progress');
const progressBar = player.querySelector('.progress_filled');
const durationText = player.querySelector('.current_time');
let watchedSecondsMap;
let lastSecondStarted = 0.0;
let rewatchCounter = 0;

function initializeWatchStatistics() {
  if (!watchedSecondsMap) {
    watchedSecondsMap = new Map();
    var durationInSeconds = Math.ceil(video.duration);
    for (let x = 0; x < durationInSeconds; x++) {
      watchedSecondsMap.set(x, 0);
    }
  }
}

function checkRewatchProgress() {
  const rewatchPercent = (rewatchCounter / video.duration) * 100.0;
  if (rewatchPercent > 25.0) {
    console.log('More than 25% of the video has been rewatched');
  }
}

function incrementSecondWatches(second) {
  let watchTimes = watchedSecondsMap.get(second) + 1;
  watchedSecondsMap.set(second, watchTimes);
  // Add to rewatch counter only on the second watch
  if (watchTimes == 2) {
    rewatchCounter++;
  }
  checkRewatchProgress();
}

function togglePlay() {
  const method = video.paused ? 'play' : 'pause';
  video[method]();
}

// Displays current video time, broken into <minutes>:<seconds>
function updateCurrentTimeDisplay() {
  const minutes = Math.floor(video.currentTime / 60);
  let seconds = Math.floor(video.currentTime);
  // Pad a leading 0 for display purposes
  if (seconds < 10) {
    seconds = "0" + seconds;
  }
  durationText.textContent = minutes + ":" + seconds;
}

function handleProgress() {
  const watched = video.currentTime - lastSecondStarted;
  if (watched > 1) {
    lastSecondStarted = Math.floor(video.currentTime);
    incrementSecondWatches(Math.floor(lastSecondStarted));
  }
  const percent = (video.currentTime / video.duration) * 100;
  progressBar.style.flexBasis = `${percent}%`;
  updateCurrentTimeDisplay();
}

function scrub(e) {
  const scrubTime = (e.offsetX / progress.offsetWidth) * video.duration;
  video.currentTime = scrubTime;
  // Set lastSecondStarted to new time to prevent negative comparison values
  lastSecondStarted = Math.floor(video.currentTime);
  updateCurrentTimeDisplay();
}

/* Hook up the event listeners */
video.addEventListener('click', togglePlay);
video.addEventListener('timeupdate', handleProgress);
video.addEventListener('canplay', initializeWatchStatistics);

let mousedown = false;
progress.addEventListener('click', scrub);
progress.addEventListener('mousemove', (e) => mousedown && scrub(e));
progress.addEventListener('mousedown', () => mousedown = true);
progress.addEventListener('mouseup', () => mousedown = false);
