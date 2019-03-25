require "json"
file = File.open(File.dirname(__FILE__) + '/drinks.json')

data = JSON.parse(file.read)
data.each do |key, value|
    d = Drink.create({
        name: value['name'],
        ingredients: value['ingredients'],
        default: true,
        tag: 'none'
    })
    if value.key?("image")
        d.image.attach(io: File.open('app/assets/images/' + value['image']), filename: 'drink.png')
    else
        d.image.attach(io: File.open('app/assets/images/drink.png'), filename: 'drink.png')
    end
    
    d.save
end