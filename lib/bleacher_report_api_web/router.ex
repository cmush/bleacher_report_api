defmodule BleacherReportApiWeb.Router do
  use BleacherReportApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BleacherReportApiWeb do
    pipe_through :api
  end
end
