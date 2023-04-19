describe "the login_openai method" do
  context 'success' do
    it 'returns an answer to the question'
      # Setup: Instantiate, mock, prepare doubles
      response = double('response')
      allow(response).to receive(:success).and_return(true)
      allow(response).to receive(:answer).and_return('answer')
    it "should return response, and response is not nil" do
    expect(login_openai).not_to be_nil
  end
end