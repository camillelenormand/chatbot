# lib/chatbot-chat.rb

require 'http'
require 'json'
require 'dotenv'

Dotenv.load('.env')

# Read all user_inputs to cease chat

$api_key = ENV["OPENAI_API_KEY"]

def converse_with_ai(api_key)

  previous_inputs = []
  previous_responses = []

  # Read conversation history
  if File.exist?('conversation.json')
    conversation_history = JSON.parse(File.read('conversation.json'))
    previous_inputs = conversation_history['inputs']
    previous_responses = conversation_history['responses']
  end

  # Launch chat and gets user_input
  puts "How may I help you?"
  user_input = gets.chomp()

    while user_input do 

    previous_inputs << user_input

    url = "https://api.openai.com/v1/engines/text-babbage-001/completions"

    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{api_key}"
    }

    data = {
      "prompt" => "#{previous_inputs}",
      "max_tokens" => 100,
      "temperature" => 0
    }

    response = HTTP.post(url, headers: headers, body: data.to_json)
    response_body = JSON.parse(response.body.to_s)
    response_string = response_body['choices'][0]['text'].strip

    puts "Réponse: "
    puts response_string
    
    previous_responses << response_string

    conversation_history = {
      inputs: previous_inputs,
      responses: previous_responses
    }
  
    File.write('conversation.json', JSON.generate(conversation_history))

    puts "How may I help you?"
    user_input = gets.chomp()

    break if (user_input.include?("STOP") || user_input.include?("Au revoir"))
  end
  puts "Au revoir"
end

converse_with_ai($api_key)