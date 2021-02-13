require 'rails_helper'

describe 'GET /books', type: :request do
  it 'returns all books' do
    FactoryBot.create(:book, title: 'Cook Book', author:'Andri Yabu')
    FactoryBot.create(:book, title: 'Baristha Book', author:'Andri Yabu')
    get '/api/v1/books'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(2)
  end
end
