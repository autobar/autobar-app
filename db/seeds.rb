require "json"
drinkFile = File.open(File.dirname(__FILE__) + '/drinks.json')
userFile = File.open(File.dirname(__FILE__) + '/users.json')
drinkData = JSON.parse(drinkFile.read)
userData = JSON.parse(userFile.read)

userData.each do |key, value|
    u = User.create({
        name: value['name'],
        phone_number: value['phone_number'],
        drivers_license: value['drivers_license']
    })
    if value.key?('is_admin')
        u.is_admin = value['is_admin']
        u.save
    end
end

drinkData.each do |key, value|
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