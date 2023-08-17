import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const currentUserId = document.getElementById('current-user-info').getAttribute('data-user-id');
    console.log(currentUserId);
    if (data.action === 'delete') {
      const deletedCommentContainer = document.querySelector(`#comment_${data.comment_id}`);
      if (deletedCommentContainer) {
      deletedCommentContainer.remove();
      }
    } else {
      const html = `
        <div class="card" id="comment_${data.comment.id}">
          <div class="card-body">
            <div class="comment-user">
              <div class="comment-user-name">${data.user.name}</div>
              <div class="comment-user-body">${data.comment.body}</div>
              <div class="comment-user-time">${data.comment.created_at}</div>
              ${
                data.comment.user_id == currentUserId
                ? `
              <a class="delete-comment-button" 
                        data-turbo-method="delete" 
                        data-turbo-confirm="本当に削除しますか？" 
                        data-comment-id="${data.comment.id}" 
                        href="/posts/${data.comment.post_id}/comments/${data.comment.id}">
                        <i class="bi bi-trash"></i>
              </a>`
                : ''
              }
            </div>
          </div>
        </div>
      `;
      const comments = document.getElementById('comments');
      const newComment = document.getElementById('comment_body');
      comments.insertAdjacentHTML('afterbegin', html);
      newComment.value='';
    }
  },
});
