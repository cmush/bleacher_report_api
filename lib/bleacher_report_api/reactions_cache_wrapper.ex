defmodule BleacherReportApi.ReactionsCacheWrapper do
  @moduledoc """
  Wrapper module for the user content reactions (in-memory) cache
  - handled in this program by ETS
  - Idea inspired by:
  (i) https://elixirforum.com/t/ets-created-on-application-init/21608/2
  (ii) https://elixir-lang.org/getting-started/mix-otp/ets.html
  (iii) https://elixirschool.com/en/lessons/specifics/ets/
  """
  use GenServer

  def init(arg) do
    :ets.new(:content_reactions_cache, [
      # ensure all reactions are unique
      :set,
      # table accessible to all processes
      :public,
      :named_table,
      {:read_concurrency, true},
      {:write_concurrency, true}
    ])

    IO.puts("ReactionsCacheWrapper successfully started")
    {:ok, arg}
  end

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def list do
    # list all reactions
    # :ets.match(:content_reactions_cache, {:"$1", :"$2"})
    # :ets.match_object(:content_reactions_cache, {:"$1", :"$2"})
    # as objects
    :ets.select(:content_reactions_cache, [{{:"$1", :"$2"}, [], [:"$_"]}])
  end

  @doc """
  list all reactions then filter by content_id to get all reactions to specific content
  """
  def list_by_content_id(content_id) do
    # this solution is not optimal and needs further improvement since the operation will get
    # slower the bigger the list of reactions is.
    # possible solution, research match_spec queries and have the filtering happen right from
    # within the ets query
    try do
      reactions =
        :ets.select(:content_reactions_cache, [{{:"$1", :"$2"}, [], [:"$_"]}])
        |> Enum.filter(fn {_reaction_id, %{"content_id" => c_id}} -> c_id == content_id end)

      {:ok, reactions}
    rescue
      MatchError -> :no_reactions_for_content_id
    end
  end

  def get(key) do
    case :ets.lookup(:content_reactions_cache, key) do
      [] ->
        nil

      [{_key, value}] ->
        value
    end
  end

  def add_cache_reaction(key, value) do
    # We use insert_new/2 here to get a response when an attempt at duplicating the reaction id occurs
    # This necessitates a separate update method (probably overkill since insert/2 works just fine).
    case :ets.insert_new(:content_reactions_cache, {key, value}) do
      true -> {:ok, key}
      false -> {:error, :duplicate_reaction}
    end
  end

  def remove_cache_reaction(key) do
    # you can only remove a fire reaction if it already exists in storage
    # removing a nonexistent reaction should error out
    case {get(key), :ets.delete(:content_reactions_cache, key)} do
      {nil, _} -> {:error, :reaction_nonexistent}
      {_, true} -> {:ok, key}
      {_, false} -> {:error, :unable_to_delete_reaction}
    end
  end
end
