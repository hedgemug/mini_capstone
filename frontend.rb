require 'unirest'

while true
  system "clear"

  puts "Welcome to my Nerd Store"
  puts "make a selection"
  puts "    [1] See all products"
  puts "    [1.5] Search by product name"
  puts "    [2] See one product"
  puts "    [3] Create a new product"
  puts "    [4] Update a product"
  puts "    [5] Destroy a product"
  puts "    [6] Signup"
  puts "    [7] Login"
  puts "    [8] Logout"
  puts "    [9] Create an order"
  puts "    [10] See all my orders"
  puts "    [q] To quit"

  input_option = gets.chomp

  if input_option == "1"
    response = Unirest.get("http://localhost:3000/products")
    products = response.body
    puts JSON.pretty_generate(products)

  elsif input_option == "1.5"
    puts "Enter product name: "
    product_name = gets.chomp
    puts "Here are all the products matching #{product_name}: "
    response = Unirest.get("http://localhost:3000/products?search=#{product_name}")
    products = response.body
    puts JSON.pretty_generate(products)
    
  elsif input_option == "2"
    print "Enter product id: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/products/#{input_id}")
    product = response.body
    puts JSON.pretty_generate(product)
  elsif input_option == "3"
    client_params = {}

    print "Name: "
    client_params[:name] = gets.chomp

    print "Description: "
    client_params[:description] = gets.chomp

    print "Price: "
    client_params[:price] = gets.chomp

    print "Image Url: "
    client_params[:image_url] = gets.chomp

    print "Supplier ID: "
    client_params[:supplier_id] = gets.chomp

    response = Unirest.post(
                            "http://localhost:3000/products",
                            parameters: client_params
                            )
    product_data = response.body

    if product_data["errors"]
      puts "Error saving your product!"
      puts product_data["errors"]
    else
      puts JSON.pretty_generate(product_data) 
    end

  elsif input_option == "4"
    print "Enter product id: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/products/#{input_id}")
    product = response.body

    client_params = {}

    print "Name (#{product["name"]}): "
    client_params[:name] = gets.chomp

    print "Description (#{product["description"]}): "
    client_params[:description] = gets.chomp

    print "Price (#{product["price"]}): "
    client_params[:price] = gets.chomp

    print "Image Url (#{product["image_url"]}): "
    client_params[:image_url] = gets.chomp

    client_params.delete_if { |key, value| value.empty? }

    response = Unirest.patch(
                            "http://localhost:3000/products/#{input_id}",
                            parameters: client_params
                            )
    product_data = response.body

    puts JSON.pretty_generate(product_data)
  elsif input_option == "5"
    print "Enter product id: "
    input_id = gets.chomp

    response = Unirest.delete("http://localhost:3000/products/#{input_id}")
    data = response.body
    puts data["message"]
  elsif input_option == "6"
    puts "Signup: "
    params = {}
    puts "First name: "
    params[:first_name] = gets.chomp
    puts "Last name: "
    params[:last_name] = gets.chomp
    puts "Email: "
    params[:email] = gets.chomp
    puts "Password: "
    params[:password] = gets.chomp
    puts "Password Confirmation: "
    params[:password_confirmation] = gets.chomp
    response = Unirest.post("http://localhost:3000/users", parameters: params)
    puts JSON.pretty_generate(response.body)
  elsif input_option == "7"
    puts "Login:"
    puts "User email: "
    input_email = gets.chomp
    puts "User password: "
    input_password = gets.chomp
    response = Unirest.post("http://localhost:3000/user_token", parameters: {auth: {email: input_email, password: input_password}})  
    # Save the JSON web token from the response
    jwt = response.body["jwt"]
    p jwt
    # Include the jwt in the headers of any future web requests
    Unirest.default_header("Authorization", "Bearer #{jwt}") 
  elsif input_option == "8"
    jwt = ""
    Unirest.clear_default_headers()
    puts "Logged out"
  elsif input_option == "9"
    puts "Create a new order: "
    puts "Enter product id: "
    input_product_id = gets.chomp
    puts "Enter quantity: "
    input_quantity = gets.chomp
    response = Unirest.post("http://localhost:3000/orders", parameters: {product_id: input_product_id, quantity: input_quantity})
    order = response.body
    puts JSON.pretty_generate(order)
  elsif input_option == "10"
    puts "Here are all your orders: "
    response = Unirest.get("http://localhost:3000/orders")
    orders = response.body
    puts JSON.pretty_generate(orders)
  elsif input_option == "q"
    puts "Goodbye!"
    break
  end
  "Press enter to continue"
  gets.chomp
end
























