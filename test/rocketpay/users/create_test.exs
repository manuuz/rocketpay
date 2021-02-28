defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, return an user" do
      params = %{
        name: "Emanuelle",
        password: "1234567",
        nickname: "emanuexe",
        email: "emanu@teste.com",
        age: 18
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Emanuelle", age: 18, id: ^user_id} = user
    end

    test "when there are invalid, return an user" do
      params = %{
        name: "Emanuelle",
        password: "1234",
        nickname: "emanuexe",
        email: "emanu@teste.com",
        age: 17
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]}

      assert errors_on(changeset) == expected_response
    end
  end
end
