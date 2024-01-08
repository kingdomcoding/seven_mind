defmodule SevenMindWeb.ContentManager.JSON.Tests.CategoryReadModelTest do
  use SevenMindWeb.ConnCase

  describe "Category Read Model happy path" do
    test "WHEN: A GET request is made to the index route, THEN: An empty data list is returned", %{conn: conn} do
      conn = get(conn, ~p"/api/content-manager/categories")
      %{"data" => data} = response = json_response(conn, 200)
      assert data == []
    end

    test "GIVEN: A category was created, WHEN: A GET request is made to the index route, THEN: A data list containing the category is returned", %{conn: conn} do
      category_name = "Test Category"
      {:ok, %{id: category_id}} = SevenMind.CourseManagement.UseCases.create_category(category_name)

      conn = get(conn, ~p"/api/content-manager/categories")
      %{"data" => data} = response = json_response(conn, 200)
      assert Enum.any?(data, fn category -> category["id"] == category_id && category["attributes"]["name"] == category_name end)
    end

    test "GIVEN: A category was created, WHEN: A GET request is made to the get route, THEN: The category is returned", %{conn: conn} do
      category_name = "Another Test Category"
      {:ok, %{id: category_id}} = SevenMind.CourseManagement.UseCases.create_category(category_name)

      conn = get(conn, ~p"/api/content-manager/categories/#{category_id}")
      %{"data" => category} = response = json_response(conn, 200)
      assert category["id"] == category_id && category["attributes"]["name"] == category_name
    end
  end
end
