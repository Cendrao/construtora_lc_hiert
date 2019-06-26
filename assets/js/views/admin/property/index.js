import MainView from '../../main'
import LiveSocket from "phoenix_live_view"

export default class View extends MainView {
  mount() {
    let liveSocket = new LiveSocket("/live")
    liveSocket.connect()

    super.mount()
  }

  unmount() {
    super.unmount()
  }
}
