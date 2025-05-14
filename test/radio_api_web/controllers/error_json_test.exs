defmodule RadioApiWeb.ErrorJSONTest do
  use RadioApiWeb.ConnCase, async: true

  test "renders 404" do
    assert RadioApiWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert RadioApiWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
