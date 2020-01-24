defmodule BleacherReportApi.Reactions do
  @moduledoc """
  The Reactions context.
  """
  alias BleacherReportApi.ReactionsCacheWrapper, as: RCWrapper

  @doc """
  Adds a reaction.

  ## Examples

      iex> add_reaction(%{} = reaction)
      {:ok, key}

      iex> add_reaction(%{field: bad_value})
      {:error, ...}

  """
  def add_reaction(
        %{
          "action" => "add",
          "content_id" => content_id,
          "reaction_type" => "fire",
          "type" => "reaction",
          "user_id" => user_id
        } = reaction_params
      ) do
    ## Store the reaction in the persistent database (such as Postgres) TODO
    # Reactions.create(reaction) # call to context (linked to ecto/postgres/mysql)
    ## The assumptions here are that the relevant user (user_id) and content (content_id) already exist in the
    ## persistent database into which we will record the reaction. Additionally, there exists a relationship
    ## between reactions/users and reactions/content. i.e, no reaction can be recorded from a nonexistent user
    ## or to nonexistent content.

    ## Since we are skipping the database, we use the cache for temporary storage
    RCWrapper.add_cache_reaction({content_id, user_id}, reaction_params)
  end

  @doc """
  Removes a reaction.

  ## Examples

      iex> remove_reaction(%{} = reaction)
      {:ok, key}

      iex> remove_reaction(%{field: bad_value})
      {:error, ...}

  """
  def remove_reaction(%{
        "action" => "remove",
        "content_id" => content_id,
        "reaction_type" => "fire",
        "type" => "reaction",
        "user_id" => user_id
      }) do
    RCWrapper.remove_cache_reaction({content_id, user_id})
  end

  def list_content_reactions(content_id) do
    RCWrapper.list_by_content_id(content_id)
  end
end
