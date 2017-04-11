require 'rails_helper'

describe 'routes' do
  example 'staff_root' do
    expect(get: 'http://baukis.example.com').to route_to(
      host: 'baukis.example.com',
      controller: 'staff/top',
      action: 'index'
    )
  end

  example 'customer_root' do
    expect(get: 'http://example.com/mypage').to route_to(
      host: 'example.com',
      controller: 'customer/top',
      action: 'index'
    )
  end

  example 'login form for administrator' do
    expect(get: 'http://baukis.example.com/admin/login').to route_to(
      host: 'baukis.example.com',
      controller: 'admin/sessions',
      action: 'new'
    )
  end

  it 'redirects to errors/not_found when host is not valid' do
    expect(get: 'http://foo.example.com').to route_to(
      controller: 'errors',
      action: 'routing_error'
    )
  end

  it 'redirects to errors/not_found when path is not valid' do
    expect(get: 'http://baukis.example.com/xyz').to route_to(
      controller: 'errors',
      action: 'routing_error',
      anything: 'xyz'
    )
  end
end
