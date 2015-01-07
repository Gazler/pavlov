defmodule Pavlov.Mocks do
  @moduledoc """
  Use this module to mock methods on a given module.

  ## Example
    defmodule MySpec do
      use Pavlov.Mocks

      describe "My Tests" do
        ...
      end
    end
  """

  import ExUnit.Callbacks

  defmacro __using__(_) do
    quote do
      import Pavlov.Mocks
      import Pavlov.Mocks.Matchers
    end
  end

  @doc """
  Prepares a module for stubbing. Used in conjunction with
  `.to_receive`.

  ## Example
      allow MyModule |> to_receive(...)
  """
  def allow(module, opts \\ [:no_link]) do
    case Process.whereis(String.to_atom("#{to_string(module)}_meck")) do
      nil -> setup_meck(module, opts)
      _   -> module
    end
  end

  defp setup_meck(module, opts) do
    :meck.new(module, opts)
    # Unload the module once the test exits
    on_exit fn ->
      :meck.unload(module)
    end
    module
  end

  @doc """
  Mocks a function on a module. Used in conjunction with
  `allow`.

  ## Example
      allow MyModule |> to_receive(get: fn(url) -> "<html></html>" end)

  For a method that takes no arguments and returns nil, you may use a
  simpler syntax:
      allow MyModule |> to_receive(:simple_method)
  """
  def to_receive(module, mock) when is_list mock do
    {mock, value} = hd(mock)
    :meck.expect(module, mock, value)
    {module, mock, value}
  end
  def to_receive(module, mock) do
    value = fn -> nil end
    :meck.expect(module, mock, value)
    {module, mock, value}
  end

end
