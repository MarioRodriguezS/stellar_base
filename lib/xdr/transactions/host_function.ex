defmodule StellarBase.XDR.HostFunction do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `HostFunction` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    HostFunctionArgs,
    ContractAuthList
  }

  @struct_spec XDR.Struct.new(
                 args: HostFunctionArgs,
                 auth: ContractAuthList
               )

  @type args_type :: HostFunctionArgs.t()
  @type auth_type :: ContractAuthList.t()

  @type t :: %__MODULE__{args: args_type(), auth: auth_type()}

  defstruct [:args, :auth]

  @spec new(args :: args_type(), auth :: auth_type()) :: t()
  def new(
        %HostFunctionArgs{} = args,
        %ContractAuthList{} = auth
      ),
      do: %__MODULE__{args: args, auth: auth}

  @impl true
  def encode_xdr(%__MODULE__{args: args, auth: auth}) do
    [args: args, auth: auth]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{args: args, auth: auth}) do
    [args: args, auth: auth]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [args: args, auth: auth]}, rest}} ->
        {:ok, {new(args, auth), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [args: args, auth: auth]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(args, auth), rest}
  end
end
