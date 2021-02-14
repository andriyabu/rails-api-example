require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    let(:first_author) {FactoryBot.create(:author, first_name: 'Jhon', last_name: 'Wick', age: 40)  } 
    let(:second_author) {FactoryBot.create(:author, first_name: 'Arnold', last_name: 'swize niger', age: 60)} 
    before do
      FactoryBot.create(:book, title: 'Cook Book',author: first_author)
      FactoryBot.create(:book, title: 'Baristha Book',author: second_author)
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
        post '/api/v1/books', params: {
          book: {title: 'New cook book'},
          author: {first_name: 'Andri', last_name: 'Yabu', age: '35'}
        }
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
      expect(JSON.parse(response.body)).to eq(
        {
          'id' => 135,
          'title' => 'New cook book',
          'author_name' => 'Andri Yabu',
          'author_age' => 35
        }
      )  
    end
  end

  describe 'DELETE /books/:id' do
      let(:author) {FactoryBot.create(:author, first_name: 'Abeleon', last_name: 'Godwin', age: 25)  } 
      let!(:book) {FactoryBot.create(:book, title: 'Cook Book', author: author)}
     it 'deletes a book' do
      expect {
          delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)


      expect(response).to have_http_status(:no_content)
    end
  end
end
