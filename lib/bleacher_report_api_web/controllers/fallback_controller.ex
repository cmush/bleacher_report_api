defmodule BleacherReportApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BleacherReportApiWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BleacherReportApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :duplicate_reaction}) do
    conn
    |> put_status(:conflict)
    |> put_view(BleacherReportApiWeb.ErrorView)
    |> render(:"409")
  end

  def call(conn, {:error, :reaction_nonexistent}) do
    conn
    |> put_status(:not_found)
    |> put_view(BleacherReportApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unable_to_delete_reaction}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(BleacherReportApiWeb.ErrorView)
    |> render(:"500")
  end
end
