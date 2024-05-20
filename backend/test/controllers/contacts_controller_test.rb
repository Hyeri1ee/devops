# frozen_string_literal: true

require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contacts = contacts(:jan, :peter)
    @contact = @contacts.first
  end

  test 'should get index' do
    get contacts_url, as: :json
    assert_response :success
  end

  test 'should create contact' do
    assert_difference('Contact.count') do
      post contacts_url,
           params: { contact: { email: 'k.klaasen@test.saxion.nl', fullname: 'Klaas Klaasen', shortname: 'kkl01' } }, as: :json
    end

    assert_response :created
  end

  test 'should show contact' do
    get contact_url(@contact), as: :json
    assert_response :success
  end

  test 'should find contact Jan Jansen' do
    get search_url(shortname: 'jja'), as: :json
    assert_response :success
    assert_match (/"fullname":"Jan Jansen"/), @response.body
  end

  test 'should find contact Peter Peters' do
    get search_url(shortname: 'ppe01'), as: :json
    assert_response :success
    assert_match(/"fullname":"Peter Peters"/, @response.body)
  end

  test 'should find both contacts' do
    get search_url(shortname: '01'), as: :json
    assert_response :success
    assert_equal 2, JSON.parse(@response.body).length
  end

  test 'should find any contact with shortname tst01' do
    get search_url(shortname: 'tst01'), as: :json
    assert_response :success
    assert_equal 0, JSON.parse(@response.body).length
  end
end
