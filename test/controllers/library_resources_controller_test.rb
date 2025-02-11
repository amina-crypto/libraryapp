require "test_helper"

class LibraryResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @library_resource = library_resources(:one)
  end

  test "should get index" do
    get library_resources_url
    assert_response :success
  end

  test "should get new" do
    get new_library_resource_url
    assert_response :success
  end

  test "should create library_resource" do
    assert_difference("LibraryResource.count") do
      post library_resources_url, params: { library_resource: { description: @library_resource.description, language: @library_resource.language, publish_year: @library_resource.publish_year, publisher: @library_resource.publisher, title: @library_resource.title, type: @library_resource.type } }
    end

    assert_redirected_to library_resource_url(LibraryResource.last)
  end

  test "should show library_resource" do
    get library_resource_url(@library_resource)
    assert_response :success
  end

  test "should get edit" do
    get edit_library_resource_url(@library_resource)
    assert_response :success
  end

  test "should update library_resource" do
    patch library_resource_url(@library_resource), params: { library_resource: { description: @library_resource.description, language: @library_resource.language, publish_year: @library_resource.publish_year, publisher: @library_resource.publisher, title: @library_resource.title, type: @library_resource.type } }
    assert_redirected_to library_resource_url(@library_resource)
  end

  test "should destroy library_resource" do
    assert_difference("LibraryResource.count", -1) do
      delete library_resource_url(@library_resource)
    end

    assert_redirected_to library_resources_url
  end
end
