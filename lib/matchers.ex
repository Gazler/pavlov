defmodule Pavlov.Matchers do
  @moduledoc """
  Provides several matcher functions.
  Matchers accept two values, `actual` and `expected`, and return a Boolean
  """

  @doc """
  Performs an equality test between two values using ==.

  Example:
    eq(1, 2) # => false
    eq("a", "a") # => true
  """
  @spec eq(any, any) :: boolean
  def eq(actual, expected) do
    actual == expected
  end

  @doc """
  Performs an equality test between a given expression and 'true'.

  Example:
    be_true(nil, 1==1) # => true
    be_true(nil, "a"=="b") # => false
  """
  @spec be_true(any, any) :: boolean
  def be_true(_, exp) do
    exp == true
  end

  @doc """
  Performs a truthy check with a given expression.

  Example:
    be_truthy(nil, 1) # => true
    be_truthy(nil, "a") # => true
    be_truthy(nil, nil) # => false
    be_truthy(nil, false) # => false
  """
  @spec be_truthy(any, any) :: boolean
  def be_truthy(_, exp) do
    exp
  end

  @doc """
  Performs a falsey check with a given expression.

  Example:
  be_falsey(nil, 1) # => false
  be_falsey(nil, "a") # => false
  be_falsey(nil, nil) # => true
  be_falsey(nil, false) # => true
  """
  @spec be_falsey(any, any) :: boolean
  def be_falsey(_, exp) do
    !exp
  end
end
