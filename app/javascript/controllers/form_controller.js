import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  formAction() {
    const timer = setTimeout(() => {
      this.element.reset();
      const messagesWindow = document.getElementById('room_messages_div');
      messagesWindow.scrollTop = messagesWindow.scrollHeight;
      clearTimeout(timer);
    }, 75)
  }
}
