require 'rails_helper'

RSpec.feature "Guest can search properties", type: :feature do
  scenario "guests can search by city" do
    skip
    listing = create(:listing, status: 1)
    create(:listing_image, listing_id: listing.id)

    visit root_path

    within(".search_bar") do
      expect(page).to have_field("city")
      expect(page).to have_field("zip_code")
      expect(page).to have_field("check_in")
      expect(page).to have_field("check_out")
      expect(page).to have_selector(:link_or_button, 'Search')
    end

    fill_in "city", with: "#{listing.address.city}"
    fill_in "state", with: "#{listing.address.state}"
    click_on "Search"

    expect(current_path).to eq(search_path)

    expect(page).to have_content(listing.name)
  end

  scenario "guests can search by zip_code" do
    skip
    listing = create(:listing, status: 1)
    create(:listing_image, listing_id: listing.id)


    visit root_path

    fill_in "zip_code", with: "#{listing.address.zip_code}"
    click_on "Search"

    expect(current_path).to eq(search_path)

      expect(page).to have_content(listing.name)
  end

  scenario "guest can search by dates" do
    skip
    listing = create(:listing, status: 1)
    create(:listing_image, listing_id: listing.id)

    user = create(:user)
    host = create(:user)
    trip = Trip.create!(user_id: user.id,
    host_id: host.id,
    trip_status: 0,
    num_guests: 3,
    start_date: Date.today,
    end_date: Date.tomorrow,
    listing_id: listing.id)

    visit root_path

    fill_in "check_in", with: "#{Date.today + 3}"
    fill_in "check_out", with: "#{Date.today + 5}"
    click_on "Search"

    expect(current_path).to_not have_content(listing.name)
  end

  scenario "guest can search by dates sad path" do
    skip
    listing = create(:listing, status: 1)
    create(:listing_image, listing_id: listing.id)

    user = create(:user)
    host = create(:user)
    trip = Trip.create!(user_id: user.id,
    host_id: host.id,
    trip_status: 0,
    num_guests: 3,
    start_date: Date.today,
    end_date: Date.tomorrow,
    listing_id: listing.id)

    visit root_path

    fill_in "check_in", with: "#{Date.today}"
    fill_in "check_out", with: "#{Date.tomorrow}"
    click_on "Search"

    expect(current_path).to_not have_content(listing.name)
  end

  scenario "guests can search by number of accomodations" do
    skip
    listing = create(:listing, accomodates: 4, status: 1)
    create(:listing_image, listing_id: listing.id)

    visit root_path

    fill_in "zip_code", with: "#{listing.address.zip_code}"
    fill_in "num_guests", with: 3
    click_on "Search"

    expect(current_path).to eq(search_path)

    within(".results") do
      expect(page).to have_content(listing.name)
    end
  end

  scenario "guests can search by number of accomodations sad path" do
    skip
    listing = create(:listing, accomodates: 4, status: 1)
    create(:listing_image, listing_id: listing.id)

    visit root_path

    fill_in "zip_code", with: "#{listing.address.zip_code}"
    fill_in "num_guests", with: 5
    click_on "Search"

    expect(current_path).to eq(search_path)

    within(".results") do
      expect(page).to_not have_content(listing.name)
    end
  end
end