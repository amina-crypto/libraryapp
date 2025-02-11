require "application_system_test_case"

class LoansTest < ApplicationSystemTestCase
  setup do
    @loan = loans(:one)
  end

  test "visiting the index" do
    visit loans_url
    assert_selector "h1", text: "Loans"
  end

  test "should create loan" do
    visit loans_url
    click_on "New loan"

    fill_in "Due date", with: @loan.due_date
    fill_in "Library resource", with: @loan.library_resource_id
    fill_in "Loan date", with: @loan.loan_date
    fill_in "Returned at", with: @loan.returned_at
    fill_in "User", with: @loan.user_id
    click_on "Create Loan"

    assert_text "Loan was successfully created"
    click_on "Back"
  end

  test "should update Loan" do
    visit loan_url(@loan)
    click_on "Edit this loan", match: :first

    fill_in "Due date", with: @loan.due_date.to_s
    fill_in "Library resource", with: @loan.library_resource_id
    fill_in "Loan date", with: @loan.loan_date.to_s
    fill_in "Returned at", with: @loan.returned_at.to_s
    fill_in "User", with: @loan.user_id
    click_on "Update Loan"

    assert_text "Loan was successfully updated"
    click_on "Back"
  end

  test "should destroy Loan" do
    visit loan_url(@loan)
    click_on "Destroy this loan", match: :first

    assert_text "Loan was successfully destroyed"
  end
end
