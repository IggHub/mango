import {Socket} from "phoenix"
let socket = new Socket("/socket", {params: {token: window.userToken}})
socket.connect()

let channel = socket.channel("pos", {})
channel.join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp)
    $("#intro-text").text(resp.message)
  })
  .receive("error", resp => { console.log("Unable to join", resp) })


channel.on('message:new', payload => {
  console.log('payload:', payload)
  renderMessage(payload, "MangoRobot")
})

let chatMessages = $("#pos-chat-room")

let renderMessage = (payload, user) => {
  let template = document.createElement("li")
  template.innerHTML = `<div class="chat-body">
      <div class="header">
        <strong class="primary-font">${user}</strong>
      </div>
      <p>${payload.message}</p>
    </div>`
  chatMessages.append(template);
}

export default socket
