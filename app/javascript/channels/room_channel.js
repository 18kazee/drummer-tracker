import consumer from "./consumer"

const roomDataElement = document.getElementById("room-data");
const ROOM_ID = roomDataElement ? roomDataElement.dataset.roomId : null;

if (ROOM_ID) {
  consumer.subscriptions.create({ channel: "RoomChannel", room_id: ROOM_ID }, {
    connected() {
      console.log("Connected to room channel!");
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      const currentUserId = document.getElementById('room-current-user').getAttribute('data-user-id');
      const messageElement = document.getElementById('messages');
      const newMessage = document.createElement('div');
      newMessage.classList.add('message');

      if (currentUserId == data.data.user.id) {
        newMessage.classList.add('my-message');
      } else {
        newMessage.classList.add('other-message');
      }

      newMessage.textContent += `${data.data.user.name}: ${data.data.message}`;
      messageElement.appendChild(newMessage);

      messageElement.scrollTop = messageElement.scrollHeight;

      const messageInput = document.getElementById('message_content');
      messageInput.value = ''; // Clear the input field

      const submitButton = document.querySelector("input[type='submit']");
      const trimmedValue = messageInput.value.trim();
      submitButton.disabled = trimmedValue === "";
    }
  });

  // Catch the input event to enable/disable submit button
  const messageInput = document.getElementById('message_content');
  messageInput.addEventListener('input', () => {
    const submitButton = document.querySelector("input[type='submit']");
    const trimmedValue = messageInput.value.trim();
    submitButton.disabled = trimmedValue === "";
  });
}

