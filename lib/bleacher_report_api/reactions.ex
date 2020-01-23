defmodule BleacherReportApi.Reactions do
  @moduledoc """
  The Reactions context.
  """

  import Ecto.Query, warn: false
  alias BleacherReportApi.Repo

  alias BleacherReportApi.Reactions.Reaction

  @doc """
  Returns the list of reactions.

  ## Examples

      iex> list_reactions()
      [%Reaction{}, ...]

  """
  def list_reactions do
    raise "TODO"
  end

  @doc """
  Gets a single reaction.

  Raises if the Reaction does not exist.

  ## Examples

      iex> get_reaction!(123)
      %Reaction{}

  """
  def get_reaction!(id), do: raise "TODO"

  @doc """
  Creates a reaction.

  ## Examples

      iex> create_reaction(%{field: value})
      {:ok, %Reaction{}}

      iex> create_reaction(%{field: bad_value})
      {:error, ...}

  """
  def create_reaction(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a reaction.

  ## Examples

      iex> update_reaction(reaction, %{field: new_value})
      {:ok, %Reaction{}}

      iex> update_reaction(reaction, %{field: bad_value})
      {:error, ...}

  """
  def update_reaction(%Reaction{} = reaction, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Reaction.

  ## Examples

      iex> delete_reaction(reaction)
      {:ok, %Reaction{}}

      iex> delete_reaction(reaction)
      {:error, ...}

  """
  def delete_reaction(%Reaction{} = reaction) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking reaction changes.

  ## Examples

      iex> change_reaction(reaction)
      %Todo{...}

  """
  def change_reaction(%Reaction{} = reaction) do
    raise "TODO"
  end
end
