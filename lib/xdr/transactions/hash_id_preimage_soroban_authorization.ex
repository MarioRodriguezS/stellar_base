defmodule StellarBase.XDR.HashIDPreimageSorobanAuthorization do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `HashIDPreimageSorobanAuthorization` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    Hash,
    Int64,
    UInt32,
    SorobanAuthorizedInvocation
  }

  @struct_spec XDR.Struct.new(
                 network_id: Hash,
                 nonce: Int64,
                 signature_expiration_ledger: UInt32,
                 invocation: SorobanAuthorizedInvocation
               )

  @type network_id_type :: Hash.t()
  @type nonce_type :: Int64.t()
  @type signature_expiration_ledger_type :: UInt32.t()
  @type invocation_type :: SorobanAuthorizedInvocation.t()

  @type t :: %__MODULE__{
          network_id: network_id_type(),
          nonce: nonce_type(),
          signature_expiration_ledger: signature_expiration_ledger_type(),
          invocation: invocation_type()
        }

  defstruct [:network_id, :nonce, :signature_expiration_ledger, :invocation]

  @spec new(
          network_id :: network_id_type(),
          nonce :: nonce_type(),
          signature_expiration_ledger :: signature_expiration_ledger_type(),
          invocation :: invocation_type()
        ) :: t()
  def new(
        %Hash{} = network_id,
        %Int64{} = nonce,
        %UInt32{} = signature_expiration_ledger,
        %SorobanAuthorizedInvocation{} = invocation
      ),
      do: %__MODULE__{
        network_id: network_id,
        nonce: nonce,
        signature_expiration_ledger: signature_expiration_ledger,
        invocation: invocation
      }

  @impl true
  def encode_xdr(%__MODULE__{
        network_id: network_id,
        nonce: nonce,
        signature_expiration_ledger: signature_expiration_ledger,
        invocation: invocation
      }) do
    [
      network_id: network_id,
      nonce: nonce,
      signature_expiration_ledger: signature_expiration_ledger,
      invocation: invocation
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        network_id: network_id,
        nonce: nonce,
        signature_expiration_ledger: signature_expiration_ledger,
        invocation: invocation
      }) do
    [
      network_id: network_id,
      nonce: nonce,
      signature_expiration_ledger: signature_expiration_ledger,
      invocation: invocation
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [
            network_id: network_id,
            nonce: nonce,
            signature_expiration_ledger: signature_expiration_ledger,
            invocation: invocation
          ]
        }, rest}} ->
        {:ok, {new(network_id, nonce, signature_expiration_ledger, invocation), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         network_id: network_id,
         nonce: nonce,
         signature_expiration_ledger: signature_expiration_ledger,
         invocation: invocation
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(network_id, nonce, signature_expiration_ledger, invocation), rest}
  end
end
