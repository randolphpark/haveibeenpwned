defmodule Haveibeenpwned.Database do
  @moduledoc """
  Context for performing hash database read operations
  """
  alias Haveibeenpwned.Database.IO

  @database_entry_count 10
  @database_entry_length 44

  @doc """
  Reads the specified portion of the haveibeenpwned hash database, beginning
  from `offset` and continuing up to the length of an entry
  """
  def read_entry(offset, length \\ @database_entry_length) do
    GenServer.call(IO, {:read_entry, [offset: offset, length: length]})
  end

  @doc """
  Searches the Haveibeenpwned database for matching hashes via a binary search.
  If the supplied password is compromised, returns a `{:warning, count}` tuple.
  If it is not compromised, returns an `{:ok, password}` tuple.
  """
  def password_pwned?(password) when is_binary(password) do
    password |> hash_binary() |> password_pwned?(password)
  end

  def password_pwned?(_) do
    raise(ArgumentError, "supplied password must be a valid binary")
  end

  defp password_pwned?(subject, original) do
    # TODO: perform binary search
    {:ok, original}
  end

  @doc """
  Hashes the supplied binary and returns it as a readable Base16 string
  """
  def hash_binary(binary) when is_binary(binary) do
    :sha |> :crypto.hash(binary) |> Base.encode16()
  end

  def hash_binary(_), do: raise(ArgumentError, "supplied argument must be a valid binary")
end
