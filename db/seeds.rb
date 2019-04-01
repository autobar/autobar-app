require "json"
drinkFile = File.open(File.dirname(__FILE__) + '/drinks.json')
userFile = File.open(File.dirname(__FILE__) + '/users.json')
ingredientFile = File.open(File.dirname(__FILE__) + '/ingredients.json')

drinkData = JSON.parse(drinkFile.read)
userData = JSON.parse(userFile.read)
ingredientData = JSON.parse(ingredientFile.read)

ingredientData.each do |type, value|
    value.each do |name, pump|
        ing = Ingredient.create(
            name: name,
            pump: pump
        )
        if type == "liquor"
            ing.liquor = true
        else
            ing.mixer = true
        end
        ing.save
    end
end

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
        #ingredients: value['ingredients'],
        default: true,
        tag: 'none'
    })
    if value.key?("image")
        d.image.attach(io: File.open('app/assets/images/' + value['image']), filename: 'drink.png')
    else
        d.image.attach(io: File.open('app/assets/images/drink.png'), filename: 'drink.png')
    end
    value['ingredients'].each do |type, set|
        set.each do |name, amount|
            ing = Ingredient.find_by(name: name)
            if ing.nil?
                raise "[ERROR]: couldn't find ingredient - " + name
            end
            ing = ing.dup
            ing.amount = amount
            ing.drink = d
            ing.save
        end
    end
    d.save
end