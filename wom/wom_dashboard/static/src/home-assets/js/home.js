function startTimer() {
  // Set the initial countdown duration in seconds
  let countdownDuration = 1 * 24 * 60 * 60 + 20 * 60 * 60 + 50 * 60 + 23;

  function updateTimer() {
    const days = Math.floor(countdownDuration / (24 * 60 * 60));
    const hours = Math.floor((countdownDuration % (24 * 60 * 60)) / 3600);
    const minutes = Math.floor((countdownDuration % 3600) / 60);
    const seconds = countdownDuration % 60;
    console.log("************here",days,minutes,seconds)

    document.getElementById("tdays").textContent = `${days}`;
    document.getElementById("thours").textContent = `${hours}`;

    document.getElementById("tminutes").textContent = `${minutes}`;

    document.getElementById("tseconds").textContent = `${seconds}`;

    if (countdownDuration > 0) {
      countdownDuration--;
    } else {
      // Reset the countdown when it reaches zero
      countdownDuration = 1 * 24 * 60 * 60 + 20 * 60 * 60 + 50 * 60 + 23;
    }
  }

  // Update the timer every second
  setInterval(updateTimer, 1000);
}

// Start the timer when the page loads
startTimer();
