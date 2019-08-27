const refreshButton = document.querySelector(".refresh-button")

const clickRefresh = () => {
  refreshButton.click();
  console.log("!");
}

clickRefresh();
setInterval(clickRefresh, 10 * 60 * 1000);
