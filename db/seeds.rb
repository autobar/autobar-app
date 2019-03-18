require "json"
file = File.open(File.dirname(__FILE__) + '/drinks.json')

data = JSON.parse(file.read)
data.each do |key, value|
    Drink.create({
        name: value['name'],
        ingredients: value['ingredients'],
        default: true,
        tag: 'none'
    })
end