defmodule BleacherReportApiWeb.ReactionControllerTest do
  use BleacherReportApiWeb.ConnCase

  # alias BleacherReportApi.Reactions

  @add_valid_reaction %{
    action: "add",
    reaction_type: "fire",
    type: "reaction",
    content_id: "some content_id",
    user_id: "some user_id"
  }
  @remove_valid_reaction %{
    action: "remove",
    reaction_type: "fire",
    type: "reaction",
    content_id: "some content_id",
    user_id: "some user_id"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "user reacts to content" do
    test "renders added reaction when data provided is valid", %{conn: conn} do
      conn = post(conn, Routes.reaction_path(conn, :react), @add_valid_reaction)

      assert %{
               "action" => "add",
               "content_id" => "some content_id",
               "reaction_type" => "fire",
               "type" => "reaction",
               "user_id" => "some user_id"
             } = json_response(conn, 201)["data"]
    end

    test "renders removed reaction when data provided is valid", %{conn: conn} do
      # setup (add a reaction to remove) -> typically done using fixtures
      post(conn, Routes.reaction_path(conn, :react), @add_valid_reaction)
      # remove added reaction
      conn = post(conn, Routes.reaction_path(conn, :react), @remove_valid_reaction)

      assert %{
               "action" => "remove",
               "content_id" => "some content_id",
               "reaction_type" => "fire",
               "type" => "reaction",
               "user_id" => "some user_id"
             } = json_response(conn, 201)["data"]
    end
  end

  describe "count users' reaction to content" do
    test "return count of fire reactions", %{conn: conn} do
      # setup (add a reaction to count) -> typically done using fixtures
      post(conn, Routes.reaction_path(conn, :react), @add_valid_reaction)

      conn =
        get(conn, Routes.reaction_path(conn, :count_reactions, @add_valid_reaction.content_id))

      %{"content_id" => "some content_id", "reactions_count" => %{"fire" => 1}} =
        json_response(conn, 200)
    end
  end
end
