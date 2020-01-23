defmodule BleacherReportApiWeb.ReactionController do
  use BleacherReportApiWeb, :controller

  alias BleacherReportApi.Reactions

  action_fallback BleacherReportApiWeb.FallbackController

  def create(conn, %{"reaction" => reaction_params}) do
    #    with {:ok, %Reaction{} = reaction} <- Reactions.create_reaction(reaction_params) do
    #      conn
    #      |> put_status(:created)
    #      |> put_resp_header("location", Routes.reaction_path(conn, :show, reaction))
    #      |> render("show.json", reaction: reaction)
    #    end
    :ok
  end
end
