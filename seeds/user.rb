u = Model::User::Base.find_by(email: 'info@playthe.world')

return unless u

u.password = 'as12as'
u.password_confirmation = 'as12as'
u.save!

puts 'DONE!'