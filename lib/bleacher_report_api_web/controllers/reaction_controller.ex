defmodule BleacherReportApiWeb.ReactionController do
  use BleacherReportApiWeb, :controller

  alias BleacherReportApi.Reactions

  action_fallback BleacherReportApiWeb.FallbackController

  def react(
        conn,
        %{
          "action" => "add",
          "reaction_type" => "fire",
          "type" => "reaction"
        } = reaction_params
      ) do
    with {:ok, _reaction} <- Reactions.add_reaction(reaction_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.reaction_path(conn, :react, reaction))
      |> render("show.json", reaction: reaction_params)
    end
  end

  def react(
        conn,
        %{
          "action" => "remove",
          "reaction_type" => "fire",
          "type" => "reaction"
        } = reaction_params
      ) do
    with {:ok, _reaction} <- Reactions.remove_reaction(reaction_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.reaction_path(conn, :react, reaction))
      |> render("show.json", reaction: reaction_params)
    end
  end

  def count_reactions(conn, %{"content_id" => content_id}) do
    with {:ok, reactions} <- Reactions.list_content_reactions(content_id) do
      case Enum.count(reactions) do
        0 ->
          conn
          |> put_status(:not_found)
          |> put_view(BleacherReportApiWeb.ErrorView)
          |> render(:"404")

        reaction_count ->
          conn
          |> put_status(:ok)
          # |> put_resp_header("location", Routes.reaction_path(conn, :count_reactions, reaction))
          |> json(%{
            content_id: content_id,
            reactions_count: %{fire: reaction_count}
          })
      end
    end
  end
end
