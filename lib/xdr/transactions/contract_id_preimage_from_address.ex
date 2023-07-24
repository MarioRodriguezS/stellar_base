defmodule StellarBase.XDR.ContractIDPreimageFromAddress do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `ContractIDPreimageFromAddress` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    SCAddress,
    UInt256
  }

  @struct_spec XDR.Struct.new(
                 address: SCAddress,
                 salt: UInt256
               )

  @type address_type :: SCAddress.t()
  @type salt_type :: UInt256.t()

  @type t :: %__MODULE__{address: address_type(), salt: salt_type()}

  defstruct [:address, :salt]

  @spec new(address :: address_type(), salt :: salt_type()) :: t()
  def new(
        %SCAddress{} = address,
        %UInt256{} = salt
      ),
      do: %__MODULE__{address: address, salt: salt}

  @impl true
  def encode_xdr(%__MODULE__{address: address, salt: salt}) do
    [address: address, salt: salt]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{address: address, salt: salt}) do
    [address: address, salt: salt]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [address: address, salt: salt]}, rest}} ->
        {:ok, {new(address, salt), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [address: address, salt: salt]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(address, salt), rest}
  end
end
