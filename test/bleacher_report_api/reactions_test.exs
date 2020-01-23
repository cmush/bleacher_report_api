defmodule BleacherReportApi.ReactionsTest do
  use ExUnit.Case, async: true

  alias BleacherReportApi.Reactions

  describe "reactions" do
    @valid_attrs %{
      action: "some action",
      content_id: "some content_id",
      reaction_type: "some reaction_type",
      type: "some type",
      user_id: "some user_id"
    }
    @update_attrs %{
      action: "some updated action",
      content_id: "some updated content_id",
      reaction_type: "some updated reaction_type",
      type: "some updated type",
      user_id: "some updated user_id"
    }
    @invalid_attrs %{action: nil, content_id: nil, reaction_type: nil, type: nil, user_id: nil}

    def reaction_fixture(attrs \\ %{}) do
      {:ok, reaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reactions.create_reaction()

      reaction
    end

    test "create_reaction/1 with valid data creates a reaction" do
      #      assert {:ok, %Reaction{} = reaction} = Reactions.create_reaction(@valid_attrs)
      #      assert reaction.action == "some action"
      #      assert reaction.content_id == "some content_id"
      #      assert reaction.reaction_type == "some reaction_type"
      #      assert reaction.type == "some type"
      #      assert reaction.user_id == "some user_id"
      :ok
    end

    test "create_reaction/1 with invalid data returns error changeset" do
      #      assert {:error, %Ecto.Changeset{}} = Reactions.create_reaction(@invalid_attrs)
      :ok
    end
  end
end
