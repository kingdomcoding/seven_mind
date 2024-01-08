defmodule SevenMindWeb.Public.Json.ErrorJsonTest do
  use SevenMindWeb.ConnCase, async: true

  test "renders 404" do
    assert SevenMindWeb.Public.Json.ErrorJson.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert SevenMindWeb.Public.Json.ErrorJson.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
