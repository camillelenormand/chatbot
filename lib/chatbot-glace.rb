require 'http'
require 'json'
require 'dotenv'
require 'lib/chatbot/data.json'

Dotenv.load('.env')

$api_key = ENV["OPENAI_API_KEY"]

def login_openai(api_key)


# check if ENV is empty 
puts ENV.empty? # false

# check if api_key is empty 
puts api_key.nil? # false

url = "https://api.openai.com/v1/engines/text-babbage-001/completions"

headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

data = {
  "prompt" => "5 goûts de glace",
  "max_tokens" => 100,
  "temperature" => 0.7
}

response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)
response.status.success?? response_string = response_body['choices'][0]['text'].strip : response.status.to_s

puts "Voici 5 parfums de glace :"
puts response_body

end

login_openai($api_key)