const refreshButton = document.querySelector(".refresh-button")

const clickRefresh = () => {
  refreshButton.click();
}

clickRefresh();
setInterval(clickRefresh, 10 * 60 * 1000);
