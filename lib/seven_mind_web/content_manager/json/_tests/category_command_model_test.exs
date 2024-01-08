defmodule SevenMindWeb.ContentManager.JSON.Tests.CategoryCommandModelTest do
  use SevenMindWeb.ConnCase

  describe "Category Command Model happy path" do
    test "WHEN: A valid POST request is made to the category post route, THEN: A success response is returned", %{conn: conn} do
      category_name = "Another Test Category"

      conn =
        conn
        |> put_req_header("content-type", "application/vnd.api+json")
        |> post(~p"/api/content-manager/categories/", %{data: %{attributes: %{name: category_name}}})

      %{"data" => category} = json_response(conn, 201)
      assert category["attributes"]["name"] == category_name
    end

    test "GIVEN: A valid POST request was made to the category post route, WHEN: A GET request is made for the category, THEN: The category is returned", %{conn: conn} do
      category_name = "Yet Another Test Category"
      conn =
        conn
        |> put_req_header("content-type", "application/vnd.api+json")
        |> post(~p"/api/content-manager/categories/", %{data: %{attributes: %{name: category_name}}})

      response = json_response(conn, 201)
      category_id = response["data"]["id"]
      conn = get(conn, ~p"/api/content-manager/categories/#{category_id}")

      %{"data" => category} = json_response(conn, 200)
      assert category["id"] == category_id && category["attributes"]["name"] == category_name
    end
  end
end
