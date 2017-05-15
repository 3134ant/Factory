require "./factory.rb"

Customer = Factory.new(:name, :address, :zip) do
  def greeting
    "Hello #{name}!"
  end
end

joe = Customer.new('Joe Smith', '123 Maple, Anytown NC', 12345)
# => #<struct Customer name="Joe Smith", address="123 Maple, Anytown NC", zip=12345>

puts joe.name
puts joe['name']
puts joe[:name]
puts joe[0]
puts joe.greeting
puts joe[1]
puts joe['address']
