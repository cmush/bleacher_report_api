defmodule BleacherReportApiWeb.Router do
  use BleacherReportApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BleacherReportApiWeb do
    pipe_through :api

    post "/reaction", ReactionController, :react
    get "/reaction_counts/:content_id", ReactionController, :count_reactions
  end
end
