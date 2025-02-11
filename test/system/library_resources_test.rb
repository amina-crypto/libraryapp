require "application_system_test_case"

class LibraryResourcesTest < ApplicationSystemTestCase
  setup do
    @library_resource = library_resources(:one)
  end

  test "visiting the index" do
    visit library_resources_url
    assert_selector "h1", text: "Library resources"
  end

  test "should create library resource" do
    visit library_resources_url
    click_on "New library resource"

    fill_in "Description", with: @library_resource.description
    fill_in "Language", with: @library_resource.language
    fill_in "Publish year", with: @library_resource.publish_year
    fill_in "Publisher", with: @library_resource.publisher
    fill_in "Title", with: @library_resource.title
    fill_in "Type", with: @library_resource.type
    click_on "Create Library resource"

    assert_text "Library resource was successfully created"
    click_on "Back"
  end

  test "should update Library resource" do
    visit library_resource_url(@library_resource)
    click_on "Edit this library resource", match: :first

    fill_in "Description", with: @library_resource.description
    fill_in "Language", with: @library_resource.language
    fill_in "Publish year", with: @library_resource.publish_year
    fill_in "Publisher", with: @library_resource.publisher
    fill_in "Title", with: @library_resource.title
    fill_in "Type", with: @library_resource.type
    click_on "Update Library resource"

    assert_text "Library resource was successfully updated"
    click_on "Back"
  end

  test "should destroy Library resource" do
    visit library_resource_url(@library_resource)
    click_on "Destroy this library resource", match: :first

    assert_text "Library resource was successfully destroyed"
  end
end
