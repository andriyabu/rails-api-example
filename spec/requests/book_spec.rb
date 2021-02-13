require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    before do
      FactoryBot.create(:book, title: 'Cook Book', author:'Andri Yabu')
      FactoryBot.create(:book, title: 'Baristha Book', author:'Andri Yabu')
    end
    
    it 'returns all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /books' do
    it 'create a new book' do
      expect {
        post '/api/v1/books', params: {book: {title: 'New cook book', author: 'Aladin'}}
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /books/:id' do
    let!(:book) {FactoryBot.create(:book, title: 'Cook Book', author:'Andri Yabu')}
    it 'deletes a book' do
      expect {
          delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)


      expect(response).to have_http_status(:no_content)
    end
  end
end
