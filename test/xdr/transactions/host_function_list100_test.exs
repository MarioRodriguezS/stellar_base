defmodule StellarBase.XDR.HostFunctionList100Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCVal,
    SCValType,
    SCVec,
    Int64,
    HostFunctionType,
    HostFunctionArgs,
    HostFunctionList100,
    HostFunction,
    PublicKeyType,
    UInt256,
    PublicKey,
    ContractAuthList,
    AccountID,
    AuthorizedInvocation,
    AuthorizedInvocationList,
    AddressWithNonce,
    ContractAuth,
    Hash,
    Int64,
    SCAddress,
    SCAddressType,
    SCSymbol,
    OptionalAddressWithNonce,
    UInt64
  }

  alias StellarBase.StrKey

  describe "HostFunction" do
    setup do
      ## HostFunction
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      sc_vals = [scval1, scval2]
      sc_vec = SCVec.new(sc_vals)
      host_function_type = HostFunctionType.new(:HOST_FUNCTION_TYPE_INVOKE_CONTRACT)
      host_function_args = HostFunctionArgs.new(sc_vec, host_function_type)

      ## LedgerFootprint
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      ## ContractAuthList
      # AddressWithNonce
      sc_address_type = SCAddressType.new(:SC_ADDRESS_TYPE_ACCOUNT)
      sc_address = SCAddress.new(account_id, sc_address_type)
      nonce = UInt64.new(123)

      address_with_nonce =
        sc_address |> AddressWithNonce.new(nonce) |> OptionalAddressWithNonce.new()

      # AuthorizedInvocation
      contract_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      function_name = SCSymbol.new("Hello")

      authorized_invocation =
        AuthorizedInvocation.new(
          contract_id,
          function_name,
          sc_vec,
          AuthorizedInvocationList.new()
        )

      auth = ContractAuth.new(address_with_nonce, authorized_invocation, sc_vec)
      auth_list = ContractAuthList.new([auth, auth])
      host_function = [HostFunction.new(host_function_args, auth_list)]
      host_function_list = HostFunctionList100.new(host_function)

      %{
        host_function_list: host_function_list,
        host_function: host_function,
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0,
            0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178,
            144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210,
            37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 0, 0, 123, 71, 67, 73,
            90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84, 72, 77, 68,
            90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0,
            2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0,
            0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0,
            0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149,
            154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2,
            227, 119, 0, 0, 0, 0, 0, 0, 0, 123, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55,
            79, 85, 83, 52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0,
            0, 5, 72, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3,
            0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0,
            0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2>>
      }
    end

    test "new/1", %{host_function: host_function} do
      %HostFunctionList100{items: ^host_function} = HostFunctionList100.new(host_function)
    end

    test "encode_xdr/1", %{
      host_function_list: host_function_list,
      binary: binary
    } do
      {:ok, ^binary} = HostFunctionList100.encode_xdr(host_function_list)
    end

    test "encode_xdr!/1", %{
      host_function_list: host_function_list,
      binary: binary
    } do
      ^binary = HostFunctionList100.encode_xdr!(host_function_list)
    end

    test "decode_xdr/2", %{
      host_function_list: host_function_list,
      binary: binary
    } do
      {:ok, {^host_function_list, ""}} = HostFunctionList100.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HostFunctionList100.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      host_function_list: host_function_list,
      binary: binary
    } do
      {^host_function_list, ^binary} = HostFunctionList100.decode_xdr!(binary <> binary)
    end
  end
end
