defmodule BleacherReportApiWeb.ReactionView do
  use BleacherReportApiWeb, :view
  alias BleacherReportApiWeb.ReactionView

  def render("index.json", %{reactions: reactions}) do
    %{data: render_many(reactions, ReactionView, "reaction.json")}
  end

  def render("show.json", %{reaction: reaction}) do
    %{data: render_one(reaction, ReactionView, "reaction.json")}
  end

  def render("reaction.json", %{
        reaction: %{
          "action" => action,
          "content_id" => content_id,
          "reaction_type" => reaction_type,
          "type" => type,
          "user_id" => user_id
        }
      }) do
    %{
      type: type,
      action: action,
      content_id: content_id,
      user_id: user_id,
      reaction_type: reaction_type
    }
  end
end
