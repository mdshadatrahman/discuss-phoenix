defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  alias DiscussWeb.CommentController
  alias Discuss.Discussions
  alias Discuss.Discussions.Comment
  alias Discuss.Repo

  @impl true
  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)

    topic = Discussions.get_topic!(topic_id)
    topic = Discussions.get_topic_comments(topic)

    # {:ok, topic, socket}
    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  @impl true
  def handle_in(_name, %{"content" => content}, socket) do
    topic = socket.assigns.topic

    case Discussions.create_comment(topic, %{content: content}) do
      {:ok, _comment} ->
        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, %{error: changeset}}, socket}
    end

    # case Repo.insert(changeset) do
    #   {:ok, _comment} ->
    #     {:reply, :ok, socket}

    #   {:error, _reason} ->
    #     {:reply, {:error, %{error: changeset}}, socket}
    # end
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (comments:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
